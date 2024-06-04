import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flux/collection/myprofilemodel.dart';

class DbController{

final db=FirebaseFirestore.instance;



Stream<QuerySnapshot> getAllUser(){

  return db.collection("Profile Info").snapshots();



}



}