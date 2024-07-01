import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flux/accountverification.dart';
import 'package:flux/channelmenu.dart';
import 'package:flux/firstpage.dart';
import 'package:flux/model/addressmodel.dart';
import 'package:flux/model/myprofilemodel.dart';
import 'package:flux/myprofile.dart';
import 'package:flux/profile.dart';
import 'package:flux/createprofile.dart';
import 'package:flux/savedmessage.dart';
import 'package:flux/settings.dart';
import 'package:flux/verification.dart';

class drawer extends StatefulWidget {
  const drawer({Key? key});

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  Myprofilemodel? currentUserModel;
  Addressmodel? currentAddressModel;

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
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyProfile())),
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
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingsPage(
                            user: currentUserModel,
                            address: currentAddressModel))),
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
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VerificationScreen())),
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
                            onPressed: () async {
                              await FirebaseAuth.instance
                                  .signOut()
                                  .then((value) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => page1(),
                                    ),
                                    (route) => false);
                              });
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
