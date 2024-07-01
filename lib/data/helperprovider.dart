import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flux/utils/string.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinput/pinput.dart';

class HelperProvider with ChangeNotifier {


  
  File? selectedimage;

  String? url;

  Future imagePicker() async {
    final pickimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickimage == null) return null;

    selectedimage = File(pickimage.path);

    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    final curenttime = DateTime.now();

    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child('profileImages/$curenttime')
        .putFile(selectedimage!, metadata);
    TaskSnapshot snapshot = await uploadTask;

    url = await snapshot.ref.getDownloadURL();

    
    notifyListeners();
  }





  Stream<int> getUserLenght() {
    return db.collection('Profile Info').snapshots().map((snapshot) => snapshot.docs.length);
  }
}
