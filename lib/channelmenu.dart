import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flux/collection/myprofilemodel.dart';
import 'package:flux/collection/newchannelmodel.dart';
import 'package:flux/data/channel_controller.dart';

class Member {
  final String name;
  final String imageUrl; // Assuming you have an image URL for each member
  final DateTime lastSeen;

  const Member({
    required this.name,
    required this.imageUrl,
    required this.lastSeen,
  });
}

Myprofilemodel? ownerProfile;

class cmenu extends StatelessWidget {
  ChannelModel channelModel;

  cmenu({super.key, required this.channelModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<DocumentSnapshot>(
            stream: ChannelController().getSelectedCahnnel(channelModel.channelId),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(),);
              }
              channelModel=ChannelModel.fromData(snapshot.data!.data() as Map<String,dynamic>);
              if(snapshot.hasData){
                return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 150,
                    child: channelModel.profile == ""
                        ? const Icon(Icons.image)
                        : Image.network(channelModel.profile),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    channelModel.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // const Text(
                  //   "Design Community",
                  //   style: TextStyle(fontSize: 16, color: Colors.black54),
                  // ),
                  const SizedBox(height: 5),
                  Text(
                    "${channelModel.members.length} Subscriber",
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      channelModel.ownerId == FirebaseAuth.instance.currentUser!.uid
                          ? const SizedBox()
                          : StreamBuilder<DocumentSnapshot>(
                              stream: ChannelController()
                                  .checkTheCurrentUserAlredysubscribedChannelorNot(
                                      FirebaseAuth.instance.currentUser!.uid,
                                      channelModel.channelId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: SizedBox(),
                                  );
                                }
                                bool subscribed;
                                if (snapshot.data!.exists) {
                                  subscribed = true;
                                } else {
                                  subscribed = false;
                                }
                                if (snapshot.hasData) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      if (subscribed) {
                                        ChannelController().unSubscribeChannel(
                                            channelModel.channelId,
                                            FirebaseAuth.instance.currentUser!.uid);
                                      } else {
                                        ChannelController()
                                            .addNewSubscriberToChannel(
                                                channelModel.channelId,
                                                FirebaseAuth
                                                    .instance.currentUser!.uid);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: subscribed
                                          ? const Color.fromARGB(255, 203, 203, 203)
                                          : Colors.blueAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      minimumSize: const Size(150, 50),
                                    ),
                                    child: Text(
                                        subscribed ? "Subscribed" : "Subscribe"),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              }),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          minimumSize: const Size(150, 50),
                        ),
                        child: const Text("Share"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "About This Channel",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "The latest UI/UX Design News And Information On Projects",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder<DocumentSnapshot>(
                      future: ChannelController().getUSerData(channelModel.ownerId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.data!.exists) {
                          ownerProfile = Myprofilemodel.fromData(
                              snapshot.data!.data() as Map<String, dynamic>);
                        }
                        return ownerProfile == null
                            ? const Center(
                                child: Text("Loading..."),
                              )
                            : Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(ownerProfile!.url),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ownerProfile!.firstname,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const Text(
                                          "Owner",
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                      }),
                  const SizedBox(height: 20),
                  const Text(
                    "Subscribers",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  channelModel.members.isEmpty
                      ? const Center(
                          child: Text("No Subscribers"),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: channelModel.members.length,
                          itemBuilder: (context, index) {
                            // final member = members[index];
                            return FutureBuilder(
                              future: ChannelController().getUSerData(channelModel.members[index]),
                              builder: (context,snapshot) {
                                if(snapshot.connectionState==ConnectionState.waiting){
                                  return Center(child: CircularProgressIndicator(),);
                                }
                                Myprofilemodel subscribers
                                =Myprofilemodel.fromData(snapshot.data!.data() as Map<String,dynamic>);
                                return  ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(subscribers.url),
                                      ),
                                      title: Text(subscribers.firstname),
                                      // subtitle: Text(getLastSeenText(subscribers.)),
                                    );
                              }
                            );
                          },
                        ),
                ],
              );

              }else{
                return const SizedBox();
              }
              
            }
          ),
        ),
      ),
    );
  }

  String getLastSeenText(DateTime lastSeen) {
    final now = DateTime.now();
    final difference = now.difference(lastSeen);

    if (difference.inSeconds < 60) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inDays}d ago";
    }
  }
}
