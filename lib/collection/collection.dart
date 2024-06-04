import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flux/collection/addressmodel.dart';
import 'package:flux/collection/bankmodel.dart';
import 'package:flux/collection/chatmessage_mode.dart';
import 'package:flux/collection/contestmodel.dart';
import 'package:flux/collection/model.dart';
import 'package:flux/collection/myprofilemodel.dart';
import 'package:flux/collection/newchannelmodel.dart';
import 'package:flux/collection/panmodel.dart';
import 'package:flux/collection/postworkmodel.dart';
import 'package:flux/collection/servicemodel.dart';
import 'package:flux/collection/workmodel.dart';

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
    final bankinfo = db.collection("Bank Details").doc();
    bankinfo.set(bankmodel.data(bankinfo.id));
  }

  Future addaddress(Addressmodel addressmodel) async {
    final addressinfo = db.collection("Address Details").doc();
    addressinfo.set(addressmodel.data(addressinfo.id));
  }

  Future addpan(Panmodel panmodel) async {
    final paninfo = db.collection("Pan Details").doc();
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
    serviceinfo.set(postservicemodel.data(serviceinfo.id));
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
 