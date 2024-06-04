import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Postworkmodel {
  String title;
  String description;
  double budget;
  int deadline;
  String skills;
  String category; 
  String level;
  String subCategory;
  String? workId;
  Timestamp? timestamp;
  String ?uid;

  Postworkmodel({
    required this.subCategory,
     this.workId,
    this.timestamp,
    this.uid,
    required this.title,
    required this.description,
    required this.budget,
    required this.deadline,
    required this.skills,
    required this.category,
    required this.level,
  });

  Map<String, dynamic> data(docId) => {
    "timestamp":Timestamp.now(),
    "uid":FirebaseAuth.instance.currentUser!.uid,
        "Title": title,
        "workId":docId,
        "subCategory":subCategory,
        "Description": description,
        "Budget": budget,
        "Deadline": deadline,
        "Skills": skills,
        "Category": category,
        "Level": level,
      };
  factory Postworkmodel.fromData(Map<String, dynamic> i) {
    return Postworkmodel(
      uid:i["uid"],
      timestamp:i["timestamp"],
      subCategory:i["subCategory"],
      workId:i["workId"],
      title: i["Title"],
      description: i["Description"],
      budget: i["Budget"],
      deadline: i["Deadline"],
      skills: i["Skills"],
      category: i["Category"],
      level: i["Level"],
      ); 
  }
}
