import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flux/channelchat.dart';
import 'package:flux/channels.dart';
import 'package:flux/collection/newchannelmodel.dart';
import 'package:flux/data/channel_controller.dart';
import 'package:flux/profile.dart';

class Channel {
  final String name;
  final String? iconUrl;
  final int memberCount;

  const Channel({required this.name, this.iconUrl, required this.memberCount});
}

class allchannel extends StatefulWidget {
  allchannel({super.key});

  @override
  State<allchannel> createState() => _allchannelState();
}

class _allchannelState extends State<allchannel> {
  String selectedCategory = "Subscribed";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: "Category",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value == null) {
                    return "Select the category";
                  } else {
                    return null;
                  }
                },
                items:
                    List.of(ChannelController.channelCategory + ["Subscribed"])
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                onChanged: (selected) {
                  print(selected);
                  selectedCategory = selected!;
                  setState(() {});
                }),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: selectedCategory == "Subscribed"
                    ? ChannelController().getMySubscribedChannel()
                    : ChannelController().getChannelbySorting(selectedCategory),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<ChannelModel> allChannel = [];
                  if (selectedCategory == "Subscribed") {
                    for (var i in snapshot.data!.docs) {
                      // log(i.id);
                      ChannelController()
                          .getSubscribedCahnnelDetails(i["channelID"])
                          .then((doc) {
                        allChannel.add(ChannelModel.fromData(
                            doc.data() as Map<String, dynamic>));
                      });
                    }
                  } else {
                    allChannel = snapshot.data!.docs
                        .map((e) => ChannelModel.fromData(
                            e.data() as Map<String, dynamic>))
                        .toList();
                  }

                  if (snapshot.hasData) {
                    return allChannel.isEmpty
                        ? const Center(
                            child: Text("No Channels"),
                          )
                        : ListView.builder(
                            itemCount: allChannel.length,
                            itemBuilder: (context, index) {
                              final channel = allChannel[index];
                              return ListTile(
                                leading: (channel.profile != "")
                                    ? CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(channel.profile),
                                      )
                                    : const Icon(Icons.chat),
                                title: Text(channel.name),
                                subtitle: Text(
                                    "${channel.members.map((e) => e).toList().join(",")} Members"),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => cchat(
                                                channelModel: channel,
                                              ))); // Replace MyWork with your actual destination widget
                                },
                              );
                            },
                          );
                  } else {
                    return const SizedBox();
                  }
                }),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
