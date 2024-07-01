import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flux/chatpage.dart';
import 'package:flux/model/myprofilemodel.dart';
import 'package:flux/data/db_controller.dart';
import 'package:flux/drawer.dart';
import 'package:flux/myprofile.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController _searchController = TextEditingController();
  Myprofilemodel? currentUserModel;

  @override
  void initState() {
    super.initState();
    fetchCurrentUserProfile().then((user) {
      setState(() {
        currentUserModel = user;
      });
    });
  }

  // Fetch the current user's profile data
  Future<Myprofilemodel?> fetchCurrentUserProfile() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Profile Info")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (snapshot.exists) {
      return Myprofilemodel.fromData(snapshot.data()!);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),
      appBar: AppBar(
        title: const Text("FLUX", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(8, 38, 76, 1),
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu, color: Colors.white),
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: currentUserModel != null
                ? CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(currentUserModel!.url),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyProfile()),
                        );
                      },
                    ),
                  )
                : const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(8, 38, 76, 1)),
                    ),
                  ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search users...',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 15.0,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {}); // Trigger rebuild to update search results
                  },
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: DbController().getAllUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<Myprofilemodel> listOfUsers = snapshot.data!.docs
                      .map((e) => Myprofilemodel.fromData(e.data() as Map<String, dynamic>))
                      .toList();
                  List<Myprofilemodel> users = [];
                  String query = _searchController.text.toLowerCase();
                  for (var i in listOfUsers) {
                    if (i.id != FirebaseAuth.instance.currentUser!.uid &&
                        (i.firstname.toLowerCase().contains(query) ||
                            i.secondname.toLowerCase().contains(query))) {
                      users.add(i);
                    }
                  }
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(users[index].firstname),
                        subtitle: Text("Message $index"),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(users[index].url),
                        ),
                        trailing: Text("1:00 PM"), // Replace with actual time
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                senderProfileModel: users[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
