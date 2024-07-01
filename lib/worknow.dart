import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flux/model/myprofilemodel.dart';
import 'package:flux/contest.dart';
import 'package:flux/drawer.dart';
import 'package:flux/myworks.dart';
import 'package:flux/worknowcategories.dart';
import 'package:flux/myprofile.dart';
import 'package:flux/profile.dart';
import 'package:flux/notification.dart';
import 'package:flux/postawork.dart';

class worknow extends StatefulWidget {
  worknow({super.key});

  @override
  State<worknow> createState() => _worknowState();
}

class _worknowState extends State<worknow> {
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

  @override
  void initState() {
    super.initState();
    fetchCurrentUserProfile().then((user) {
      setState(() {
        currentUserModel = user;
      });
    });
  }

  final List<String> categoryNames = [
    "Graphic & Design",
    "Digital Marketing",
    "Writing & Translation",
    "Video & Animation",
    "Technology",
    "Gaming",
  ];

  final List<String> imageAssets = [
    "asset/pexels-toa-heftiba-şinca-1194420.jpg",
    "asset/pexels-toa-heftiba-şinca-1194420.jpg",
    "asset/pexels-toa-heftiba-şinca-1194420.jpg",
    "asset/medium-shot-man-wearing-vr-glasses.jpg",
    "asset/medium-shot-man-wearing-vr-glasses.jpg",
    "asset/pexels-toa-heftiba-şinca-1194420.jpg",
  ];

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
              icon: const Icon(Icons.menu, color: Colors.white));
        }),
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(" Work Category",
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                // IconButton(
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(builder: (context) => const noti()),
                //       );
                //     },
                //     icon: const Icon(Icons.notifications_active_rounded))
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: categoryNames.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.3,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (currentUserModel != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => worknowcategories(
                              selectedCategory: categoryNames[index],
                              senderProfileModel: currentUserModel!, // Pass currentUserModel
                            ),
                          ),
                        );
                      }
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  imageAssets[index],
                                  scale: 1,
                                  width: 115,
                                ),
                              ),
                            ),
                            Text(
                              categoryNames[index],
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PostWorkPage()),
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black)),
                    child: const Text("Post Work")),
                // TextButton(
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(builder: (context) => ContestsPage()),
                //       );
                //     },
                //     child: const Text("Contests"))
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
