// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class ServiceController {
//   static List<String> servises = [
//     "Plumbing",
//     "Electrician",
//     "Taxi",
//     "Courier",
//     "Food delivery",
//     "Cleaning",
//   ];

//   final db = FirebaseFirestore.instance;

//   Stream<QuerySnapshot> getMyPostSelectedCategoryWork(category) {
//     final dos = db
//         .collection('Post Service Info')
//         .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid);
//     return dos.where('Category', isEqualTo: category).snapshots();
//   }

//   Stream<QuerySnapshot> getAllPostExceptMinSelectedCategoryWork(category) {
//     final dos = db
//         .collection('Post Service Info')
//         .where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid);
//     return dos.where('Category', isEqualTo: category).snapshots();
//   }
// }
