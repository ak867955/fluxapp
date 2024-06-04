import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flux/channelchat.dart';
import 'package:flux/collection/newchannelmodel.dart';
import 'package:flux/data/channel_controller.dart';
import 'package:flux/newchannel.dart';

class Channel {
  final String name;
  final String? iconUrl;
  final int memberCount;

  const Channel({required this.name, this.iconUrl, required this.memberCount});
}

class mychannels extends StatelessWidget {
  const mychannels({super.key});

  @override
  Widget build(BuildContext context) {
    //  List<Channel> channels = [

    //   // Add more channels...
    // ];

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
                              subtitle: Text(
                                  "${channel.members.map((e) => e).join(",")} Members"),
                              onTap: () {
                                // Navigate based on channel name
                                // if (channel.name == "Flutter Dev") {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             cchat())); // Replace MyWork with your actual destination widget
                                // } else if (channel.name == "Samsung Inc") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => cchat(
                                              channelModel: channel,
                                            ))); // Replace MyWork with your actual destination widget
                                // }
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
