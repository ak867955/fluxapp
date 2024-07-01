import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Contestmodel {
  String title;
  String description;
  double budget;
  String skill;
  String deadline;
  String? contestId;
  Timestamp? timestamp;
  String? uid;
  String save;

  Contestmodel({
    required this.title,
    required this.description,
    required this.budget,
    required this.skill,
    required this.deadline,
    this.contestId,
    this.timestamp,
    this.uid,
    required this.save,
  });

  Map<String, dynamic> data(docId) => {
        "Title": title,
        "Description": description,
        "Budget": budget,
        "Skill": skill,
        "Deadline": deadline,
        "WorkId": docId,
        "Timestamp": timestamp ?? FieldValue.serverTimestamp(),
        "Uid": FirebaseAuth.instance.currentUser!.uid,
        'Saved':save,
      };

  factory Contestmodel.fromData(Map<String, dynamic> i) {
    return Contestmodel(
      title: i["Title"],
      description: i["Description"],
      budget: i["Budget"],
      skill: i["Skill"],
      deadline: i["Deadline"],
      contestId: i["WorkId"],
      timestamp: i["Timestamp"],
      uid: i["Uid"],
      save: i['Saved'],
    );
  }

  // Future<void> saveToFirestore() async {
  //   final docRef = FirebaseFirestore.instance.collection('SavedMessages').doc();
  //   await docRef.set(data(docRef.id));
  // }
}
