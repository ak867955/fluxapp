import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flux/model/myprofilemodel.dart';
import 'package:flux/editprofile.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  Myprofilemodel? currentUserModel;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Profile Info")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (snapshot.exists) {
      setState(() {
        currentUserModel = Myprofilemodel.fromData(snapshot.data()!);
      });
    }
  }

    String getJoinedYear() {
    if (currentUserModel!.since != null) {
      return currentUserModel!.since!;
    } else {
      // Default value or placeholder text if since is null
      return 'N/A'; // Replace with appropriate default text
    }
  }

  Future<double> initRating(int rating) async {
    if (rating <= 10) {
      return 0.5;
    } else if (rating > 10 && rating <= 20) {
      return 1;
    } else if (rating > 20 && rating <= 30) {
      return 1.5;
    } else if (rating > 30 && rating <= 40) {
      return 2;
    } else if (rating > 40 && rating <= 50) {
      return 2.5;
    } else if (rating > 50 && rating <= 60) {
      return 3;
    } else if (rating > 60 && rating <= 70) {
      return 3.5;
    } else if (rating > 70 && rating <= 80) {
      return 4;
    } else if (rating > 80 && rating <= 90) {
      return 4.5;
    } else if (rating > 90) {
      return 5;
    } else {
      return 0;
    }
  }



String getRankingText(int points) {
  if (points <= 50) {
    return "Beginner";
  } else if (points <= 100) {
    return "Intermediate";
  } else {
    return "Advanced";
  }
}

  Future<String> checkTheUserIsVerified(int rating) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Pan Details")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (snapshot.exists) {
      return initializePoint(true, rating);
    } else {
      return initializePoint(false, rating);
    }
  }

  String initializePoint(bool value, int rating) {
    if (value == false && rating < 4) {
      return "50";
    } else if (value == true && rating > 4) {
      return "150";
    } else if (value == true || rating > 4) {
      return "100";
    } else {
      return "";
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
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: currentUserModel == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
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
                  FutureBuilder<double>(
                    future: initRating(currentUserModel!.rating),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox();
                      }
                      double rating = snapshot.data!;
                      return Center(
                        child: RatingBar.builder(
                          initialRating: rating,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 40,
                          ignoreGestures: true,
                             itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            // Handle rating update if needed
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.people),
                    title: const Text(
                      "Member Since",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(getJoinedYear()), // Display joined year or default text
                  ),
                 FutureBuilder<String>(
  future: checkTheUserIsVerified(currentUserModel!.rating),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return SizedBox();
    }
    if (snapshot.hasData) {
      int points = int.parse(snapshot.data!);
      String ranking = getRankingText(points);
      return Column(
        children: [
          ListTile(
            leading: const Icon(Icons.radio_button_off_outlined),
            title: const Text(
              "Points",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text(points.toString()),
          ),
          ListTile(
            leading: const Icon(Icons.pentagon_outlined),
            title: const Text(
              "Ranking",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text(ranking),
          ),
        ],
      );
    }
    return SizedBox();
  },
),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfile(
                              currentUserModel: currentUserModel,
                            ),
                          ),
                        ).then((_) {
                          // Update profile after returning from EditProfile
                          fetchData();
                        });
                      },
                      child: const Text("Edit"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
