import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  String senderId;
  String receiverId;
  String text;
  Timestamp timestamp;
  String type;
  String? imageUrl;

  ChatMessage({
    required this.senderId, 
    required this.receiverId, 
    required this.text, 
    required this.timestamp,     
    this.type = 'text',
    this.imageUrl,  
  });
 
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'timestamp': timestamp,
      'type': type,
      'imageUrl': imageUrl,
    };
  }

  static ChatMessage fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      senderId: map['senderId'],
      receiverId: map['receiverId'], 
      text: map['text'],
      timestamp: map['timestamp'],
      type: map['type'] ?? 'text',
      imageUrl: map['imageUrl'],
    );
  }
}
