import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flux/accountverification.dart';
import 'package:flux/collection/myprofilemodel.dart';
import 'package:flux/myprofile.dart';
import 'package:flux/profile.dart';
import 'package:flux/createprofile.dart';
import 'package:flux/savedmessage.dart';
import 'package:flux/settings.dart';
import 'package:flux/verification.dart';

class drawer extends StatefulWidget {
  const drawer({super.key});

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  Myprofilemodel? currentUserModel;
  Future<Myprofilemodel?> fetchData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Profile Info")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (snapshot.exists) {
      return currentUserModel = Myprofilemodel.fromData(snapshot.data()!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 16,
      child: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(8, 38, 76, 1),
                ),
                accountName: Text(
                  '${currentUserModel!.firstname} ${currentUserModel!.secondname}',
                ),
                accountEmail: Text(currentUserModel!.email),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(currentUserModel!.url),
                ),
              ),
              ListTile(
                onTap: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => MyProfile())),
                leading: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                title: Text(
                  "Profile",
                  style: TextStyle(fontSize: 18),
                ),
                textColor: Colors.black,
              ),
              ListTile(
                onTap: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => settings())),
                leading: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                title: Text(
                  "Settings",
                  style: TextStyle(fontSize: 18),
                ),
                textColor: Colors.black,
              ),
              ListTile(
                onTap: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => smess())),
                leading: Icon(
                  Icons.save_rounded,
                  color: Colors.black,
                ),
                title: Text(
                  "Saved Messages",
                  style: TextStyle(fontSize: 18),
                ),
                textColor: Colors.black,
              ),
              ListTile(
                onTap: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => verification())),
                leading: Icon(
                  Icons.verified,
                  color: Colors.black,
                ),
                title: Text(
                  "My KYC",
                  style: TextStyle(fontSize: 18),
                ),
                textColor: Colors.black,
              ),
              ListTile(
                onTap: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => acc())),
                leading: Icon(
                  Icons.work,
                  color: Colors.black,
                ),
                title: Text(
                  "Work Now",
                  style: TextStyle(fontSize: 18),
                ),
                textColor: Colors.black,
              ),
              ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Confirm Log Out"),
                        content: Text("Are you sure you want to log out?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                            },
                            child: Text("Log Out"),
                          ),
                        ],
                      );
                    },
                  );
                },
                leading: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                title: Text(
                  "Log Out",
                  style: TextStyle(fontSize: 18),
                ),
                textColor: Colors.black,
              ),
            ],
          );
        },
      ),
    );
  }
}
