import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flux/model/chatmessage_mode.dart';
import 'package:flux/model/newchannelmodel.dart';

class ChannelController {
  final db = FirebaseFirestore.instance;

  static List<String> channelCategory = [ 
    "Entertainment",
    "Education",
    "News",
    "Movies",
    "Games",
    "Store",
    "Fashion",
    "Sports",
    "Others"
  ];

  Future createChannel(ChannelModel channelModel) async {
    final docs = db.collection("Channels").doc();
    docs.set(channelModel.data(docs.id));
  }

  Stream<QuerySnapshot> getMyChannel() {
    return db
        .collection("Channels")
        .where('OwnerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUSerData(id) async {
    final snapshot = await db.collection("Profile Info").doc(id).get();

    return snapshot;
  }

  Stream<DocumentSnapshot> getSelectedCahnnel(channelID) {
    return db.collection("Channels").doc(channelID).snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getSubscribedCahnnelDetails(
      channelID) async {
    return await db.collection("Channels").doc(channelID).get();
  }

  Stream<QuerySnapshot> getAllchannelsExceptMine() {
    return db
        .collection("Channels")
        .where("OwnerId", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  Stream<QuerySnapshot> getChannelbySorting(selectedCategory) {
    // log(selectedCategory);
    return db
        .collection("Channels")
        .where("category", isEqualTo: selectedCategory)
        .snapshots();
  }

//--------------------------SUBSCRIBE
  addNewSubscriberToChannel(channelID, subscriberId) async {
    final document = db.collection("Channels").doc(channelID);
    final subscriberDoc = db
        .collection("Profile Info")
        .doc(subscriberId)
        .collection("Subscribed Cahnnels")
        .doc(channelID);
    final snapshot = await document.get();
    List members = snapshot.data()!["Members"];

    List<dynamic> listOfMembers = [];
    if (snapshot.exists) {
      listOfMembers.addAll(members);
    }

    if (!members.contains(subscriberId)) {
      listOfMembers.add(subscriberId);
      document.update({"Members": listOfMembers});
      subscriberDoc.set({"channelID": channelID});
    }
  }

  unSubscribeChannel(channelID, subscriberId) async {
    final subscriberDoc = db
        .collection("Profile Info")
        .doc(subscriberId)
        .collection("Subscribed Cahnnels")
        .doc(channelID);
    final document = db.collection("Channels").doc(channelID);
    final snapshot = await document.get();
    List members = snapshot.data()!["Members"];
    members.remove(subscriberId);
    document.update({"Members": members});

    subscriberDoc.delete();
  }

///////----------------------------------------------------------
  Stream<DocumentSnapshot> checkTheCurrentUserAlredysubscribedChannelorNot(
      subscriberId, channelID) {
    return db
        .collection("Profile Info")
        .doc(subscriberId)
        .collection("Subscribed Cahnnels")
        .doc(channelID)
        .snapshots();
  }

  //-----------------------------
  Stream<QuerySnapshot> getMySubscribedChannel(uid) {
    return db
        .collection("Profile Info")
        .doc(uid)
        .collection("Subscribed Cahnnels")
        .snapshots();
  }

  Stream<QuerySnapshot> getsubchanels(uid) {
    return db
        .collection("Profile Info")
        .doc(uid)
        .collection("Subscribed Cahnnels")
        .snapshots();
  }

  //-------------------CHATING ---------------------

  sendMessage(String channelId, message) {
    String senderId = FirebaseAuth.instance.currentUser!.uid;
    String receiverUId = channelId;
    Timestamp timestamp = Timestamp.now();

    ChatMessage messageModel = ChatMessage( 
        senderId: senderId,
        receiverId: receiverUId,
        text: message,
        timestamp: timestamp);

    db
        .collection('Channels')
        .doc(channelId)
        .collection("message")
        .add(messageModel.toMap());
  }

  Stream<QuerySnapshot> receiveMessage(channelId) {
    return db
        .collection('Channels')
        .doc(channelId)
        .collection("message")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  Future<void> deleteChannel(String channelId) async {
    await db.collection("Channels").doc(channelId).delete();
  }
}
