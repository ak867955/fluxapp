import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flux/allchannels.dart';
import 'package:flux/model/myprofilemodel.dart';
import 'package:flux/drawer.dart';
import 'package:flux/mychannels.dart';
import 'package:flux/myprofile.dart';
import 'package:flux/subscribedchannels.dart';


class channels extends StatefulWidget {
  const channels({super.key});

  @override
  State<channels> createState() => _ChannelsState();
}

class _ChannelsState extends State<channels> {
  Myprofilemodel? currentUserModel;

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

  void initState() {
    super.initState();
    fetchCurrentUserProfile().then((user) {
      setState(() {
        currentUserModel = user;
      });
    });
  }

  int selectedTab = 0; // Initial selected tab (All Channels)

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: drawer(),
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                child:
                    Text("All Channels", style: TextStyle(color: Colors.white)),
              ),
              Tab(
                child: Text("Subscribed",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
              Tab(
                child:
                    Text("My Channels", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          title: Text("FLUX", style: TextStyle(color: Colors.white)),
          backgroundColor: Color.fromRGBO(8, 38, 76, 1),
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icon(Icons.menu, color: Colors.white),
            ),
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
        body: TabBarView(
          children: [
            allchannel(), // Use the AllChannels widget directly
            SubScribedChannelPage(),
            mychannels(),
          ],
        ), 
      ),
    );
  }
}
