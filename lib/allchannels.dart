import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flux/channelchat.dart';
import 'package:flux/model/myprofilemodel.dart';
import 'package:flux/model/newchannelmodel.dart';
import 'package:flux/data/channel_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flux/payment.dart';

class allchannel extends StatefulWidget {
  allchannel({Key? key}) : super(key: key);

  @override
  State<allchannel> createState() => _allchannelState();
}

class _allchannelState extends State<allchannel> {
  String selectedCategory = "Entertainment"; // Default category

  Future<Myprofilemodel> getCurrentUserProfile() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await FirebaseFirestore.instance
        .collection("Profile Info")
        .doc(uid)
        .get();
    return Myprofilemodel.fromData(doc.data() as Map<String, dynamic>);
  }

  Future<void> _showMyDialog(ChannelModel channelModel) async {
    Myprofilemodel senderProfileModel = await getCurrentUserProfile();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Channel Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Channel Name : ${channelModel.name}'),
                Text(
                    'Payment : ${channelModel.payment.isEmpty ? 'Free' : channelModel.payment}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Visibility(
              visible: channelModel.payment.isEmpty,
              child: TextButton(
                child: const Text('Join'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChannelChat(
                        channelModel: channelModel,
                        senderProfileModel: senderProfileModel,
                      ),
                    ),
                  );
                },
              ),
            ),
            Visibility(
              visible: channelModel.payment.isNotEmpty,
              child: TextButton(
                child: const Text('Approve'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => payment(
                        anotherUserId: channelModel.ownerId,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: DropdownButtonFormField(
              value: selectedCategory,
              decoration: const InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Select the category";
                } else {
                  return null;
                }
              },
              items: ChannelController.channelCategory
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (selected) {
                setState(() {
                  selectedCategory = selected as String;
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: selectedCategory == "Subscribed"
                  ? ChannelController()
                      .getMySubscribedChannel(FirebaseAuth.instance.currentUser!.uid)
                  : ChannelController().getChannelbySorting(selectedCategory),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<ChannelModel> allChannel = [];
                if (snapshot.hasData) {
                  allChannel = snapshot.data!.docs
                      .map((e) =>
                          ChannelModel.fromData(e.data() as Map<String, dynamic>))
                      .toList();
                }

                return allChannel.isEmpty
                    ? const Center(
                        child: Text("No Channels"),
                      )
                    : ListView.builder(
                        itemCount: allChannel.length,
                        itemBuilder: (context, index) {
                          final channel = allChannel[index];
                          return ListTile(
                            leading: (channel.profile.isNotEmpty)
                                ? CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(channel.profile),
                                  )
                                : const Icon(Icons.chat),
                            title: Text(channel.name),
                            subtitle:
                                Text("${channel.members.length} Members"),
                            trailing:
                                Text('PAYMENT :${channel.payment.isEmpty ? 'Free' : channel.payment}'),
                            onTap: () async {
                              Myprofilemodel senderProfileModel =
                                  await getCurrentUserProfile();

                              _showMyDialog(channel);
                            },
                          );
                        },
                      );
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
