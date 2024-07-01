import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flux/model/myprofilemodel.dart';
import 'package:flux/model/newchannelmodel.dart';
import 'package:flux/data/channel_controller.dart';

class Member {
  final String name;
  final String imageUrl;
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
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                channelModel = ChannelModel.fromData(snapshot.data!.data() as Map<String, dynamic>);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          height: 100,
                          width: 150,
                          child: channelModel.profile == ""
                              ? const Icon(Icons.image, size: 100, color: Colors.grey)
                              : Image.network(channelModel.profile, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        channelModel.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        "${channelModel.members.length} Subscribers",
                        style: const TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        channelModel.ownerId == FirebaseAuth.instance.currentUser!.uid
                            ? const SizedBox()
                            : StreamBuilder<DocumentSnapshot>(
                                stream: ChannelController().checkTheCurrentUserAlredysubscribedChannelorNot(
                                  FirebaseAuth.instance.currentUser!.uid,
                                  channelModel.channelId,
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(
                                      child: SizedBox(),
                                    );
                                  }
                                  bool subscribed = snapshot.data!.exists;
                                  return ElevatedButton(
                                    onPressed: () {
                                      if (subscribed) {
                                        ChannelController().unSubscribeChannel(
                                          channelModel.channelId,
                                          FirebaseAuth.instance.currentUser!.uid,
                                        );
                                      } else {
                                        ChannelController().addNewSubscriberToChannel(
                                          channelModel.channelId,
                                          FirebaseAuth.instance.currentUser!.uid,
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: subscribed ? Colors.grey : Colors.blueAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      minimumSize: const Size(150, 50),
                                    ),
                                    child: Text(subscribed ? "Subscribed" : "Subscribe"),
                                  );
                                },
                              ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     // Share functionality goes here
                        //   },
                        //   style: ElevatedButton.styleFrom(
                        //     backgroundColor: Colors.black,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(20.0),
                        //     ),
                        //     minimumSize: const Size(150, 50),
                        //   ),
                        //   child: const Text("Share"),
                        // ),
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
                    Text(
                      channelModel.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FutureBuilder<DocumentSnapshot>(
                      future: ChannelController().getUSerData(channelModel.ownerId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.data!.exists) {
                          ownerProfile = Myprofilemodel.fromData(snapshot.data!.data() as Map<String, dynamic>);
                        }
                        return ownerProfile == null
                            ? const Center(child: Text("Loading..."))
                            : Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(ownerProfile!.url),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
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
                                        style: TextStyle(fontSize: 14, color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                      },
                    ),
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
                        ? const Center(child: Text("No Subscribers"))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: channelModel.members.length,
                            itemBuilder: (context, index) {
                              return FutureBuilder<DocumentSnapshot>(
                                future: ChannelController().getUSerData(channelModel.members[index]),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(child: CircularProgressIndicator());
                                  }
                                  if (!snapshot.hasData) {
                                    return const SizedBox();
                                  }
                                  Myprofilemodel subscriber = Myprofilemodel.fromData(snapshot.data!.data() as Map<String, dynamic>);
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(subscriber.url),
                                    ),
                                    title: Text(subscriber.firstname),
                                    // subtitle: Text(getLastSeenText(subscriber.lastSeen)),  // Assuming Myprofilemodel has a lastSeen field
                                  );
                                },
                              );
                            },
                          ),
                  ],
                );
              } else {
                return const Center(child: Text("No data available"));
              }
            },
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
