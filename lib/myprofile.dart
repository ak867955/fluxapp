import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flux/calling.dart';
import 'package:flux/chatpage.dart';
import 'package:flux/collection/myprofilemodel.dart';
import 'package:flux/createprofile.dart';
import 'package:flux/dashboard.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            // child: Icon(Icons.edit),
          )
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(currentUserModel!.url),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${currentUserModel!.firstname} ${currentUserModel!.secondname}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    currentUserModel!.skill,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cake, color: Colors.black54),
                      SizedBox(width: 5),
                      Text(
                        currentUserModel!.age.toString(),
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      SizedBox(width: 20),
                      Icon(Icons.male, color: Colors.black54),
                      SizedBox(width: 5),
                      Text(
                        currentUserModel!.gender,
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    currentUserModel!.aboutme,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      const Icon(Icons.star, color: Colors.amber),
                      const Icon(Icons.star, color: Colors.amber),
                      const Icon(Icons.star, color: Colors.amber),
                      const Icon(Icons.star_half, color: Colors.amber),
                      const SizedBox(width: 5),
                      Text(
                        "4.8",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.people),
                    title: const Text(
                      "Member Since",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: const Text("2024"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.pentagon_outlined),
                    title: const Text(
                      "Ranking",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: const Text("Master"),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => dashboard()));
                      },
                      child: const Text("More"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
