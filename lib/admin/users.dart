import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flux/admin/adminprofile.dart';
import 'package:flux/model/myprofilemodel.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  int _currentPage = 1;
  final int _rowsPerPage = 5; // Number of rows per page
  List<Myprofilemodel> _users = []; // Initialize as empty list

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('Profile Info').get();
    final List<Myprofilemodel> users = querySnapshot.docs.map((doc) {
      return Myprofilemodel.fromData(doc.data() as Map<String, dynamic>);
    }).toList();

    setState(() {
      _users = users;
    });
  }

  List<Myprofilemodel> get _paginatedUsers {
    final startIndex = (_currentPage - 1) * _rowsPerPage;
    final endIndex = startIndex + _rowsPerPage;
    return _users.sublist(
      startIndex,
      endIndex > _users.length ? _users.length : endIndex,
    );
  }

  void _nextPage() {
    setState(() {
      _currentPage++;
    });
  }

  void _previousPage() {
    setState(() {
      _currentPage--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40),
          SizedBox(
            width: 900,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black, width: 3),
                ),
                label: Text(
                  "Search",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
          Center(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Joined Date')),
                DataColumn(label: Text('Status')),
              ],
              rows: _paginatedUsers
                  .map((user) => _createUserDataRow(user))
                  .toList(),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _currentPage > 1 ? _previousPage : null,
                icon: Icon(Icons.arrow_back),
              ),
              Text('Page $_currentPage'),
              IconButton(
                onPressed: (_currentPage * _rowsPerPage) < _users.length
                    ? _nextPage
                    : null,
                icon: Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _createUserDataRow(Myprofilemodel user) {
    // Adjust the date format as needed
    String joinedDate =
        DateTime.fromMillisecondsSinceEpoch(user.age).toString();
    return DataRow(
      cells: [
        DataCell(
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfile(user: user),
                ),
              );
            },
            child: Text('${user.firstname} ${user.secondname}'),
          ),
        ),
        DataCell(Text(user.email)),
        DataCell(Text(user.since.toString())),
        DataCell(
          Text(user.gender),
        ),
      ],
    );
  }
}
