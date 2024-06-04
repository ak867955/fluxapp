import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flux/chatpage.dart';
import 'package:flux/chatsearch.dart';
import 'package:flux/collection/myprofilemodel.dart';
import 'package:flux/data/db_controller.dart';
import 'package:flux/drawer.dart';
import 'package:flux/myprofile.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const drawer(),
      appBar: AppBar(
        title: const Text("FLUX", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(8, 38, 76, 1),
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          );
        }),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChatSearch()));
              },
              icon: const Icon(Icons.search, color: Colors.white)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: const AssetImage("asset/Ellipse 22.png"),
              child: InkWell(
                onTap: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyProfile()));
                }),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: DbController().getAllUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<Myprofilemodel> listOfUsers = [];
              listOfUsers = snapshot.data!.docs.map((e) {
                return Myprofilemodel.fromData(
                    e.data() as Map<String, dynamic>);
              }).toList();
              List<Myprofilemodel> users = [];
              for (var i in listOfUsers) {
                if (i.id != FirebaseAuth.instance.currentUser!.uid) {
                  users.add(i);
                }
              }
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: users.length, // Number of items in the list
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(users[index].firstname),
                      subtitle: Text("Message $index"),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            users[index].url), // Replace with your asset path
                      ),
                      trailing: Text("1$index:00 PM"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatPage(
                                    senderProfileModel: users[index],
                                  )), // Replace with your ChatPage widget
                        );
                      },
                    );
                  },
                );
              } else {
                return const SizedBox();
              }
            }),
      ),
    );
  }
}
