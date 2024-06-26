import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flux/model/myprofilemodel.dart';
import 'package:flux/myposts.dart';
import 'package:flux/channels.dart';
import 'package:flux/chat.dart';
import 'package:flux/cleaning.dart';
import 'package:flux/courier.dart';
import 'package:flux/drawer.dart';
import 'package:flux/fooddelivery.dart';
import 'package:flux/myprofile.dart';
import 'package:flux/profile.dart';
import 'package:flux/notification.dart';
import 'package:flux/servicecategories.dart';
import 'package:flux/postservice.dart';
import 'package:flux/taxi.dart';
import 'package:flux/worknow.dart';

class ServiceScreen extends StatefulWidget {
  ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
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

  final List<String> categoryNames = [
    "Plumbing",
    "Electrician",
    "Taxi",
    "Courier",
    "Food Delivery",
    "Cleaning",
  ];

  final List<String> imageAssets = [
    "asset/pexels-field-engineer-442160.jpg",
    "asset/pexels-field-engineer-442160.jpg",
    "asset/pexels-field-engineer-442160.jpg",
    "asset/pexels-field-engineer-442160.jpg",
    "asset/pexels-field-engineer-442160.jpg",
    "asset/pexels-field-engineer-442160.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),
      appBar: AppBar(
        title: Text("FLUX", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu, color: Colors.white));
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
                Text("Service Categories",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                // IconButton(
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(builder: (context) => noti()),
                //       );
                //     },
                //     icon: Icon(Icons.notifications_active_rounded))
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: categoryNames.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.3,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      switch (index) {
                        case 0:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServiceCategories(selectedCategory: 'Plumbing',)),
                          );
                          break;
                        case 1:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServiceCategories(selectedCategory: 'Electrician',)),
                          );
                          break; 
                        case 2:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServiceCategories(selectedCategory: 'Taxi',)),
                          );
                          break;
                        case 3:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>ServiceCategories(selectedCategory: 'Courier',)),
                          );
                          break;
                        case 4:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServiceCategories(selectedCategory: 'Food Delivery',)),
                          );
                          break;
                        case 5:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServiceCategories(selectedCategory: 'Cleaning',)),
                          );
                          break;
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
                              margin: EdgeInsets.all(10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  imageAssets[index],
                                  scale: 1,
                                  width: 110,
                                ),
                              ),
                            ),
                            Text(
                              categoryNames[index],
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                        MaterialPageRoute(
                            builder: (context) =>
                                PostService()), // Replace with your ServicesPage widget
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    child: Text("Post Service")),
                // SizedBox(width: 5),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyPosts()));
                    },
                    child: Text("My Posts"))
              ],
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
