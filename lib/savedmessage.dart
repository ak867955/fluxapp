import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flux/model/contestmodel.dart';
import 'package:flux/application.dart';
import 'package:flux/utils/string.dart';

class SavedMessagesScreen extends StatefulWidget {
  const SavedMessagesScreen({Key? key}) : super(key: key);

  @override
  State<SavedMessagesScreen> createState() => _SavedMessagesScreenState();
}

class _SavedMessagesScreenState extends State<SavedMessagesScreen> {
  // Stream<List<Contestmodel>> _getSavedContests() {
  //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //   return _firestore.collection('SavedMessages')

  //   .snapshots().map((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       return Contestmodel.fromData(doc.data() as Map<String, dynamic>);
  //     }).toList();
  //   });
  // }

  List<Contestmodel> contest = [];
  Future _getSavedContests(uid) async {
    final snapshot = await db
        .collection('Contests')
        .where('Saved', isEqualTo: 'saved')
        .where('Uid', isEqualTo: uid)
        .get();

    contest = snapshot.docs.map((e) {
      return Contestmodel.fromData(e.data());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Saved Messages",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Implement search functionality
              // log(auth.currentUser!.uid);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _getSavedContests(auth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          // if (snapshot.hasError) {
          //   return Center(child: Text('Error: ${snapshot.error}'));
          // }
          // if (!snapshot.hasData || snapshot.data!.isEmpty) {
          //   return Center(child: Text('No saved contests available'));
          // }

          // final savedContests = snapshot.data!;
          return contest.isEmpty
              ? Center(
                  child: Text('NO SAVED CONTEST'),
                )
              : ListView.builder(
                  itemCount: contest.length,
                  itemBuilder: (context, index) {
                    // final contest = savedContests[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigate to application screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => application()),
                        );
                      },
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage("asset/Ellipse 9.png"),
                          ),
                          title: Text(
                            contest[index].title,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            contest[index].description,
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[600]),
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
