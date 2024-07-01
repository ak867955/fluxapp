import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flux/model/chatmessage_mode.dart';

class MessageController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void sendMessage(String receiverId, String message, {String type = 'text', String? imageUrl}) { 
    String senderId = FirebaseAuth.instance.currentUser!.uid;
    Timestamp timestamp = Timestamp.now();

    ChatMessage messageModel = ChatMessage(
      senderId: senderId,
      receiverId: receiverId, 
      text: message, 
      timestamp: timestamp, 
      type: type,
      imageUrl: imageUrl, 
    );

    List<String> ids = [senderId, receiverId];
    ids.sort();

    String chatRoomId = ids.join('_');

    _db
        .collection('Chat_room')
        .doc(chatRoomId)
        .collection("message")
        .add(messageModel.toMap());
  }

  void sendRating(String receiverId, double rating) {
    String senderId = FirebaseAuth.instance.currentUser!.uid;
    Timestamp timestamp = Timestamp.now();

    ChatMessage ratingMessage = ChatMessage(
      senderId: senderId,
      receiverId: receiverId,
      text: 'Rated: $rating stars',
      timestamp: timestamp,
      type: 'rating',
    );

    List<String> ids = [senderId, receiverId];
    ids.sort();

    String chatRoomId = ids.join('_');

    _db
        .collection('Chat_room')
        .doc(chatRoomId)
        .collection("message")
        .add(ratingMessage.toMap());
  }

  Stream<QuerySnapshot> receiveMessage(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();

    String chatRoomId = ids.join('_');

    return _db
        .collection('Chat_room')
        .doc(chatRoomId)
        .collection("message")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  static ChatMessage chatMessageFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return ChatMessage(
      senderId: data['senderId'],
      receiverId: data['receiverId'],
      text: data['text'],
      timestamp: data['timestamp'],
      type: data['type'] ?? 'text',
      imageUrl: data['imageUrl'],
    );
  }

  static List<ChatMessage> chatMessageListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => chatMessageFromSnapshot(doc)).toList();
  }

    Future<void> deleteMessage(String chatRoomId, String messageId) async {
    await _db
        .collection('Chat_room')
        .doc(chatRoomId) 
        .collection("message")
        .doc(messageId)
        .delete();
  }
  
}
