import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flux/channeldata.dart';
import 'package:flux/channelmenu.dart';
import 'package:flux/channeltabbar.dart';
import 'package:flux/collection/chatmessage_mode.dart';
import 'package:flux/collection/newchannelmodel.dart';
import 'package:flux/data/channel_controller.dart';
import 'package:flux/data/message_controller.dart';
import 'package:flux/profile.dart';

class cchat extends StatelessWidget {
  ChannelModel channelModel;
  cchat({super.key, required this.channelModel});
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
                        channelModel: channelModel,
                      )),
            );
          },
          child: Text(
            channelModel.name,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
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
              backgroundImage: channelModel.profile == ""
                  ? AssetImage("asset/Ellipse 22.png")
                  : NetworkImage(channelModel.profile) as ImageProvider,
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => profile()));
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
              stream:
                  ChannelController().receiveMessage(channelModel.channelId),
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
                    return _buildMessage(message);
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
                            channelModel.channelId!, _chatControler.text);
                        _chatControler.clear();
                      }
                    }, //////////////////////////////////
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

  Widget _buildMessage(ChatMessage message) {
    final isMe = message.senderId == FirebaseAuth.instance.currentUser!.uid;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: isMe ? Colors.lightBlueAccent : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15.0),
            topRight: const Radius.circular(15.0),
            bottomLeft:
                isMe ? const Radius.circular(15.0) : const Radius.circular(0.0),
            bottomRight:
                isMe ? const Radius.circular(0.0) : const Radius.circular(15.0),
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  void _showAttachmentMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  // Implement gallery option
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  // Implement camera option
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.insert_drive_file),
                title: Text('Document'),
                onTap: () {
                  // Implement document option
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget messageBubble({required bool isSentByUser}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
            isSentByUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSentByUser)
            CircleAvatar(
              backgroundImage: AssetImage("asset/Ellipse 22.png"),
            ),
          if (!isSentByUser) SizedBox(width: 10),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: isSentByUser ? Colors.blue[200] : Colors.grey[200],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Text(
              "This is a message example.",
              style: TextStyle(
                color: isSentByUser ? Colors.black : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
