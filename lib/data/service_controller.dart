import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServiceController {


  final db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getMyPostSelectedCategoryService(category) {
    final dos = db
        .collection('Post Service Info')
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid);
    return dos.where('Category', isEqualTo: category).snapshots();
  }

  Stream<QuerySnapshot> getAllPostExceptMinSelectedCategoryService(category) {
    final dos = db
        .collection('Post Service Info')
        .where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid);
    return dos.where('Category', isEqualTo: category).snapshots();
  }
}
