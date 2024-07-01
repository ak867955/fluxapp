import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flux/channelchat.dart';
import 'package:flux/model/myprofilemodel.dart';
import 'package:flux/model/newchannelmodel.dart';
import 'package:flux/data/channel_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flux/newchannel.dart';

class Channel {
  final String name;
  final String? iconUrl;
  final int memberCount; 

  const Channel({required this.name, this.iconUrl, required this.memberCount});
}

class mychannels extends StatefulWidget {
  const mychannels({super.key});

  @override
  State<mychannels> createState() => _mychannelsState(); 
}

class _mychannelsState extends State<mychannels> { 
  Myprofilemodel? currentUserModel;

  Future<Myprofilemodel> getCurrentUserProfile() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await FirebaseFirestore.instance
        .collection("Profile Info")
        .doc(uid)
        .get();
    return Myprofilemodel.fromData(doc.data() as Map<String, dynamic>);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: ChannelController().getMyChannel(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<ChannelModel> listOfMyChannel = [];
                  listOfMyChannel = snapshot.data!.docs
                      .map((e) => ChannelModel.fromData(
                          e.data() as Map<String, dynamic>))
                      .toList();
                  return listOfMyChannel.isEmpty
                      ? Center(
                          child: Text("No Channels"),
                        )
                      : ListView.builder(
                          itemCount: listOfMyChannel.length,
                          itemBuilder: (context, index) {
                            final channel = listOfMyChannel[index];
                            return ListTile(
                              leading: (channel.profile != "")
                                  ? CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(channel.profile),
                                    )
                                  : Icon(Icons.chat),
                              title: Text(channel.name),
                              subtitle:
                                  Text("${channel.members.length} Members"),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () async {
                                  await ChannelController().deleteChannel(channel.channelId!);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Channel Deleted')),
                                  );
                                },
                              ),
                              onTap: () async {
                                Myprofilemodel senderProfileModel =
                                    await getCurrentUserProfile();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChannelChat(
                                              channelModel: channel,
                                              senderProfileModel:
                                                  senderProfileModel,
                                            )));
                              },
                            );
                          },
                        );
                }),
          ),
          SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          NewChannelPage()), // Replace with your ChatPage widget
                );
              },
              child: Text("Create Channel")),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
