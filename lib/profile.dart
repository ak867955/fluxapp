import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flux/admin/adminprofile.dart';
import 'package:flux/model/myprofilemodel.dart';
import 'package:flux/calling.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flux/model/opponetmodel.dart';
import 'package:flux/settings.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatOpponentProfile extends StatelessWidget {
  final Myprofilemodel opponentProfileModel;

  const ChatOpponentProfile({Key? key, required this.opponentProfileModel})
      : super(key: key);

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
        .doc(opponentProfileModel.id)
        .get();
    if (snapshot.exists) {
      return initializePoint(true, rating);
    } else {
      return initializePoint(false, rating);
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(opponentProfileModel.url),
              ),
              const SizedBox(height: 20),
              Text(
                "${opponentProfileModel.firstname} ${opponentProfileModel.secondname}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                opponentProfileModel.skill,
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
                  const Icon(Icons.cake, color: Colors.black54),
                  const SizedBox(width: 5),
                  Text(
                    "Age: ${opponentProfileModel.age}",
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(width: 20),
                  Icon(
                    opponentProfileModel.gender == "Male"
                        ? Icons.male
                        : Icons.female,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Gender: ${opponentProfileModel.gender}",
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                opponentProfileModel.aboutme,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ElevatedButton.icon(
                  //   onPressed: () {

                  //   },
                  //   icon: const Icon(Icons.chat),
                  //   label: const Text("Chat"),
                  //   style: ElevatedButton.styleFrom(
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      _makePhoneCall(opponentProfileModel.phoneNumber);
                    },
                    icon: const Icon(Icons.call),
                    label: const Text("Call"),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FutureBuilder<double>(
                future: initRating(opponentProfileModel.rating),
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
                trailing: Text(opponentProfileModel.since
                    .toString()), // Replace with actual member since
              ),
              FutureBuilder<String>(
                future: checkTheUserIsVerified(opponentProfileModel.rating),
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
            ],
          ),
        ));
  }
}
