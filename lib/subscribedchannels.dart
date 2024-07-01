import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flux/channels.dart';
import 'package:flux/data/channel_controller.dart';
import 'package:flux/model/newchannelmodel.dart';
import 'package:flux/utils/string.dart';

class SubScribedChannelPage extends StatefulWidget {
  const SubScribedChannelPage({super.key});

  @override
  State<SubScribedChannelPage> createState() => _SubScribedChannelPageState();
}

class _SubScribedChannelPageState extends State<SubScribedChannelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder(
            stream: ChannelController().getsubchanels(auth.currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              List<ChannelModel> allChannel = [];

              final channels = snapshot.data!.docs;

              for (var doc in channels) {
                ChannelController()
                    .getSubscribedCahnnelDetails(doc["channelID"])
                    .then((doc) {
                  allChannel.add(ChannelModel.fromData(
                      doc.data() as Map<String, dynamic>));
                });
              }

              return Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: channels.length,
                    itemBuilder: (context, index) {
                      var channelId = channels[index].id;

                      return StreamBuilder(
                        stream: db
                            .collection('Channels')
                            .doc(channelId)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          var channelModel = ChannelModel.fromData(
                            snapshot.data!.data() as Map<String, dynamic>,
                          );

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }

                          return ListTile(
                            leading: (CircleAvatar(
                              backgroundImage:
                                  NetworkImage(channelModel.profile),
                            )),
                            title: Text(channelModel.name),
                            subtitle: Text(
                                'Members ${channelModel.members.length.toString()}'),
                            onTap: () async {},
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 25,
                      );
                    },
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
