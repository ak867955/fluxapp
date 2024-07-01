import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:url_launcher/url_launcher.dart';
import 'package:flux/model/chatmessage_mode.dart';
import 'package:flux/model/myprofilemodel.dart';
import 'package:flux/data/message_controller.dart';
import 'package:flux/payment.dart';
import 'package:flux/profile.dart';

class ChatPage extends StatefulWidget {
  final Myprofilemodel? senderProfileModel;

  ChatPage({Key? key, required this.senderProfileModel}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final MessageController _messageControllerInstance = MessageController();
  final ImagePicker _imagePicker = ImagePicker();

  void _showRatingDialog(BuildContext context) {
    double _rating = 0;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rate the Service/Work'),
          content: RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 40,
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              _rating = rating;
              updatwRating(rating.toInt(), widget.senderProfileModel!.id);
            },
          ),
          actions: [
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                Navigator.of(context).pop(_rating);
              },
            ),
          ],
        );
      },
    ).then((rating) {
      if (rating != null) {
        _messageControllerInstance.sendRating(
          widget.senderProfileModel!.id!,
          rating,
        );
      }
    });
  }

  void _showAttachmentMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGallery();
                },
              ),
              ListTile(
                leading: const Icon(Icons.file_copy_sharp),
                title: const Text('Files'),
                onTap: () {
                  Navigator.pop(context);
                  _pickFile();
                },
              ),
              ListTile(
                leading: const Icon(Icons.currency_rupee),
                title: const Text('Pay'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => payment(anotherUserId: widget.senderProfileModel!.id!),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.card_giftcard),
                title: const Text('Review Card'),
                onTap: () {
                  Navigator.pop(context);
                  _showRatingDialog(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      _sendMessageWithAttachment(imageFile, 'image');
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'txt'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      _sendMessageWithAttachment(file, 'file', fileName: result.files.single.name);
    }
  }

  Future<void> _sendMessageWithAttachment(File attachment, String type, {String? fileName}) async {
    try {
      String displayName = fileName ?? attachment.path.split('/').last;
      UploadTask uploadTask = FirebaseStorage.instance
          .ref('chat_attachments/$displayName')
          .putFile(attachment);

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      _messageControllerInstance.sendMessage(
        widget.senderProfileModel!.id!,
        displayName,
        type: type,
        imageUrl: downloadUrl,
      );
    } catch (e) {
      print('Error uploading attachment: $e');
    }
  }

  final db = FirebaseFirestore.instance;

  Future getCurrentRating(aotheruserid) async {
    final snapshot = await db
        .collection("Profile Info")
        .doc(aotheruserid)
        .get();
    if (!snapshot.exists) return;
    return snapshot.data()!["Rating"];
  }

  updatwRating(int newRate, aotheruserid) async {
    getCurrentRating(aotheruserid).then((oldrate) async {
      final snapshot = await db
          .collection("Profile Info")
          .doc(aotheruserid)
          .update({
        'Rating': oldrate + newRate,
      });
    });
  }

  void _showImageDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(imageUrl),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

void _openFile(String fileUrl) async {
  try {
    print('Launching URL: $fileUrl'); // Print for debugging

    await launcher.launch(fileUrl);
  } catch (e) {
    print('Error launching $fileUrl: $e');
    // Handle error as needed
  }
}

  void _showDeleteDialog(String chatRoomId, String messageId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Message'),
          content: const Text('Are you sure you want to delete this message?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                _messageControllerInstance.deleteMessage(chatRoomId, messageId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildMessage(DocumentSnapshot messageDoc) {
    final message = ChatMessage.fromMap(messageDoc.data() as Map<String, dynamic>);
    final isMe = message.senderId == _auth.currentUser!.uid;
    final chatRoomId = _getChatRoomId(message.senderId, message.receiverId);

    return GestureDetector(
      onLongPress: () {
        _showDeleteDialog(chatRoomId, messageDoc.id);
      },
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: isMe ? Colors.lightBlueAccent : Colors.grey[200],
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15.0),
              topRight: const Radius.circular(15.0),
              bottomLeft: isMe ? const Radius.circular(15.0) : const Radius.circular(0.0),
              bottomRight: isMe ? const Radius.circular(0.0) : const Radius.circular(15.0),
            ),
          ),
          child: _buildMessageContent(message),
        ),
      ),
    );
  }

  Widget _buildMessageContent(ChatMessage message) {
    final isMe = message.senderId == _auth.currentUser!.uid;
    final isReviewRequest = message.type == 'review_request';
    final isImageMessage = message.type == 'image';
    final isFileMessage = message.type == 'file';

    if (isReviewRequest && !isMe) {
      return TextButton(
        onPressed: () {
          _showRatingDialog(context);
        },
        child: Text(message.text),
      );
    } else if (isImageMessage) {
      return GestureDetector(
        onTap: () {
          _showImageDialog(message.imageUrl!);
        },
        child: Image.network(message.imageUrl ?? ''),
      );
    } else if (isFileMessage) {
      return GestureDetector(
        onTap: () {
          _openFile(message.imageUrl!);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.insert_drive_file, size: 40.0, color: isMe ? Colors.white : Colors.black),
            Text(
              message.text,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      );
    } else {
      return Text(
        message.text,
        style: TextStyle(
          color: isMe ? Colors.white : Colors.black,
        ),
      );
    }
  }

  String _getChatRoomId(String senderId, String receiverId) {
    List<String> ids = [senderId, receiverId];
    ids.sort();
    return ids.join('_');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatOpponentProfile(
                  opponentProfileModel: widget.senderProfileModel!,
                ),
              ),
            );
          },
          child: Text(
            widget.senderProfileModel!.firstname,
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: const Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _messageControllerInstance.receiveMessage(
                widget.senderProfileModel!.id!,
                _auth.currentUser!.uid,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No messages yet'));
                }
                return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final messageDoc = snapshot.data!.docs[index];
                    return _buildMessage(messageDoc);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _showAttachmentMenu(context);
                    },
                    icon: const Icon(Icons.attach_file),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: "Type a message...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_messageController.text.isNotEmpty) {
                        _messageControllerInstance.sendMessage(
                          widget.senderProfileModel!.id!,
                          _messageController.text,
                        );
                        _messageController.clear();
                      }
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
