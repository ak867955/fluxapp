import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flux/channeltabbar.dart';
import 'package:flux/model/chatmessage_mode.dart';
import 'package:flux/model/myprofilemodel.dart';
import 'package:flux/model/newchannelmodel.dart';
import 'package:flux/data/channel_controller.dart';
import 'package:flux/profile.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ChannelChat extends StatefulWidget {
  final ChannelModel channelModel;
  final Myprofilemodel senderProfileModel;

  ChannelChat({
    Key? key,
    required this.channelModel,
    required this.senderProfileModel,
  }) : super(key: key);

  @override
  State<ChannelChat> createState() => _ChannelChatState();
}

class _ChannelChatState extends State<ChannelChat> {
  final _chatControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ctab(
                  channelModel: widget.channelModel,
                  senderProfileModel: widget.senderProfileModel,
                ),
              ),
            );
          },
          child: Text(
            widget.channelModel.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: widget.channelModel.profile == ""
                  ? AssetImage("asset/Ellipse 22.png")
                  : NetworkImage(widget.channelModel.profile) as ImageProvider,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatOpponentProfile(
                        opponentProfileModel: widget.senderProfileModel,
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Chat messages list
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: ChannelController()
                  .receiveMessage(widget.channelModel.channelId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                List<ChatMessage> messages = snapshot.data!.docs.map((doc) {
                  return ChatMessage.fromMap(
                      doc.data() as Map<String, dynamic>);
                }).toList();

                return ListView.builder(
                  reverse: true, // Display newest messages at the top
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return _buildMessage(message, snapshot.data!.docs[index].id);
                  },
                );
              },
            ),
          ),
          // Chat input bar
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
                    offset: const Offset(0, 3), // changes position of shadow
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
                      controller: _chatControler,
                      decoration: const InputDecoration(
                        hintText: "Type a message...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_chatControler.text.isNotEmpty) {
                        ChannelController().sendMessage(
                          widget.channelModel.channelId!,
                          _chatControler.text,
                        );
                        _chatControler.clear();
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

  Widget _buildMessage(ChatMessage message, String messageId) {
    final isMe = message.senderId == FirebaseAuth.instance.currentUser!.uid;
    final isImageMessage = message.type == 'image';
    final isFileMessage = message.type == 'file';

    return GestureDetector(
      onLongPress: isMe
          ? () {
              _showDeleteConfirmation(context, messageId);
            }
          : null,
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
          child: isImageMessage
              ? GestureDetector(
                  onTap: () {
                    _showImageViewer(context, message.imageUrl!);
                  },
                  child: Image.network(message.imageUrl ?? ''),
                )
              : isFileMessage
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.insert_drive_file, size: 40.0, color: isMe ? Colors.white : Colors.black),
                        Text(
                          message.text.isNotEmpty ? message.text : 'File',
                          style: TextStyle(
                            color: isMe ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      message.text,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.black,
                      ),
                    ),
        ),
      ),
    );
  }

  void _showImageViewer(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(),
          body: PhotoView(
            imageProvider: NetworkImage(imageUrl),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String messageId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Message"),
          content: Text("Are you sure you want to delete this message?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _deleteMessage(messageId);
                Navigator.of(context).pop();
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteMessage(String messageId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Channels')
          .doc(widget.channelModel.channelId!)
          .collection("message")
          .doc(messageId)
          .delete();
    } catch (e) {
      print('Error deleting message: $e');
    }
  }

  void _showAttachmentMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final picker = ImagePicker();
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);

                  if (pickedFile != null) {
                    File file = File(pickedFile.path);
                    _sendMessageWithAttachment(file, 'image');
                  }
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.file_copy_sharp),
              //   title: const Text('Files'),
              //   onTap: () async {
              //     Navigator.pop(context);
              //     FilePickerResult? result =
              //         await FilePicker.platform.pickFiles();

              //     if (result != null) {
              //       File file = File(result.files.single.path!);
              //       _sendMessageWithAttachment(file, 'file');
              //     }
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _sendMessageWithAttachment(File attachment, String type) async {
    try {
      // Upload file to Firebase Storage
      String fileName = attachment.path.split('/').last;
      UploadTask uploadTask = FirebaseStorage.instance
          .ref('chat_attachments/$fileName')
          .putFile(attachment);

      TaskSnapshot taskSnapshot = await uploadTask;

      // Get download URL of uploaded file
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // Send message with attachment URL
      String senderId = FirebaseAuth.instance.currentUser!.uid;
      String receiverUId = widget.channelModel.channelId!;
      Timestamp timestamp = Timestamp.now();

      ChatMessage messageModel = ChatMessage(
        senderId: senderId,
        receiverId: receiverUId,
        text: '',
        timestamp: timestamp,
        type: type,
        imageUrl: downloadUrl,
      );

      ChannelController()
          .db
          .collection('Channels')
          .doc(widget.channelModel.channelId!)
          .collection("message")
          .add(messageModel.toMap());
    } catch (e) {
      print('Error uploading attachment: $e');
    }
  }
}
