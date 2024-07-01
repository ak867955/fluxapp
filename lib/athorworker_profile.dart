import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flux/admin/adminprofile.dart';
import 'package:flux/chatpage.dart';
import 'package:flux/model/myprofilemodel.dart';
import 'package:flux/calling.dart';
import 'package:flux/utils/string.dart';
import 'package:url_launcher/url_launcher.dart';

class AthoWorkerProfile extends StatelessWidget {
  final String workerProfileId;

  AthoWorkerProfile({Key? key, required this.workerProfileId}) : super(key: key);

  Future<double> initRating(int rating) async {
    if (rating <= 10) {
      return .5;
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

  Future<Myprofilemodel?> getWorkerProfile() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Profile Info')
          .doc(workerProfileId)
          .get();
      if (snapshot.exists) {
        return Myprofilemodel.fromData(snapshot.data()!);
      } else {
        return null; // Handle case where document doesn't exist
      }
    } catch (e) {
      log('Error fetching profile: $e');
      return null; // Handle error gracefully
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<Myprofilemodel?>(
        future: getWorkerProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData) {
            return const Center(child: Text("Profile not found"));
          } else {
            final userProfile = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                        userProfile.url ?? 'assets/profile_placeholder.png'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "${userProfile.firstname} ${userProfile.secondname}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userProfile.skill ?? 'Skill not available',
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
                      const Text(
                        "Rating: ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      FutureBuilder<double>(
                        future: initRating(userProfile.rating),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasData) {
                            return RatingBar.builder(
                              ignoreGestures: true,
                              itemSize: 30.0,
                              initialRating: snapshot.data!,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                log(rating.toString());
                              },
                            );
                          } else {
                            return const Text("No rating available");
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Qualification: ${userProfile.qualification ?? 'Not specified'}",
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Experience: ${userProfile.experience ?? 'Not specified'}",
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Age: ${userProfile.age ?? 'Not specified'}",
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _makePhoneCall(userProfile.phoneNumber);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Call Worker",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChatPage(senderProfileModel: userProfile),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Chat With Worker",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
