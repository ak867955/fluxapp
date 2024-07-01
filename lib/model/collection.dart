import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flux/model/addressmodel.dart';
import 'package:flux/model/bankmodel.dart';
import 'package:flux/model/chatmessage_mode.dart';
import 'package:flux/model/contestmodel.dart';
import 'package:flux/model/model.dart';
import 'package:flux/model/myprofilemodel.dart';
import 'package:flux/model/newchannelmodel.dart';
import 'package:flux/model/panmodel.dart';
import 'package:flux/model/postworkmodel.dart';
import 'package:flux/model/servicemodel.dart';
import 'package:flux/model/workmodel.dart'; 

class Controller {
  // Instance of a firestore
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Future addUser(UserModel userModel, uid) async {
    // create collection
    final docRef = db.collection("User").doc(uid);
    //set or add values to collection
    docRef.set(userModel.data(docRef.id));
  }

  // Fetch single user
  UserModel? singleUserData;
  Future fetchSingleUser(id) async {
    final snapshot = await db.collection("User").doc(id).get();
    singleUserData = UserModel.fromData(snapshot.data()!);
  }

  Future addbank(Bankmodel bankmodel) async {
    final bankinfo = db.collection("Bank Details").doc(FirebaseAuth.instance.currentUser!.uid);
    bankinfo.set(bankmodel.data(bankinfo.id));
  }

  Future addaddress(Addressmodel addressmodel) async {
    final addressinfo = db.collection("Address Details").doc(FirebaseAuth.instance.currentUser!.uid);
    addressinfo.set(addressmodel.data(addressinfo.id));
  }

   Addressmodel? singaddressmodel;
    Future<Addressmodel?> getAddres(String uid) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Address Details')
          .doc(uid)
          .get();

      if (snapshot.exists) {
        singaddressmodel = Addressmodel.fromData(snapshot.data()!);
        return singaddressmodel;
      } else {
        return null; // Handle case where document doesn't exist
      }
    } catch (e) {
      print('Error fetching address: $e');
      return null; // Handle error gracefully
    }
  }

  Future addpan(Panmodel panmodel) async {
    final paninfo = db.collection("Pan Details").doc(FirebaseAuth.instance.currentUser!.uid);
    paninfo.set(panmodel.data(paninfo.id));
  }

  Future addwork(Workmodel workmodel) async {
    final workinfo = db.collection("Work Details").doc();
    workinfo.set(workmodel.data(workinfo.id));
  }

  Future addchannel(ChannelModel channelModel) async {
    final channelinfo = db.collection("Channel Details").doc();
    channelinfo.set(channelModel.data(channelinfo.id));
  }

  Future postwork(Postworkmodel postworkmodel) async {
    final postworkinfo = db.collection("Post Work Info").doc();
    postworkinfo.set(postworkmodel.data(postworkinfo.id));
  }

  Future postcontest(Contestmodel postcontestmodel) async {
    final postcontestinfo = db.collection("Post Contest Info").doc();
    postcontestinfo.set(postcontestmodel.data(postcontestinfo.id));
  }

  Future postservice(Servicemodel postservicemodel) async {
    final serviceinfo = db.collection("Post Service Info").doc();
    serviceinfo.set(postservicemodel.tojsone(serviceinfo.id));
  }

  Future addprofile(Myprofilemodel postprofilemodel) async {
    final profileinfo =
        db.collection("Profile Info").doc(auth.currentUser!.uid);
    profileinfo.set(postprofilemodel.data(profileinfo.id));
  }

  Future chatpage(ChatMessage chatmodel) async {
    final chatinfo = db.collection("Users Chats").doc(auth.currentUser!.uid);
    chatinfo.set(chatmodel.toMap());
  }
}
 