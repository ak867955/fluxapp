import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WorkNowController {
  static List<String> grephiscDesign = [
    "Visual Identity Design",
    "User Interface (UI) Design",
    "Motion Graphics Design", 
  ];

  static List<String> digitalmarketing = [
    "Search Engine Optimization (SEO)",
    "Content Marketing",
    "Social Media Marketing",
  ];

  static List<String> writingandtranslation = [
    "Copywriting",
    "Content Writing",
    "Translation",
  ];

  static List<String> videoandanimation = [
    "2D Animation",
    "3D Animation",
    "Motion Graphics Design",
  ];

  static List<String> technology = [
    "Software Development",
    "Web Development",
    "Cybersecurity",
  ];

  static List<String> gaming = [
    "Game Design",
    "Level Design",
    "3D Animation",
  ];

  final db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getMyPostSelectedCategoryWork(category) {
    final dos = db
        .collection('Post Work Info')
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid);
    return dos.where('Category', isEqualTo: category).snapshots();
  }

  Stream<QuerySnapshot> getAllPostExceptMinSelectedCategoryWork(category) {
    final dos = db
        .collection('Post Work Info')
        .where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid);
    return dos.where('Category', isEqualTo: category).snapshots();
  }
}
