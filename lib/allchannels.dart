import 'package:flutter/material.dart';
import 'package:flux/channelchat.dart';
import 'package:flux/channels.dart';
import 'package:flux/profile.dart';

class Channel { 
  final String name;
  final String? iconUrl;
  final int memberCount;
 
  const Channel({required this.name, this.iconUrl, required this.memberCount});
}

class allchannel extends StatelessWidget {
  const allchannel({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Channel> channels = [
      Channel(
          name: "Google Dev",
          iconUrl: "asset/medium-shot-man-wearing-vr-glasses.jpg",
          memberCount: 1000),
      Channel(
          name: "Apple Inc",
          iconUrl: "asset/medium-shot-man-wearing-vr-glasses.jpg",
          memberCount: 500),
      // Add more channels...
    ]; 

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: channels.length,
              itemBuilder: (context, index) {
                final channel = channels[index];
                return ListTile(
                  leading: (channel.iconUrl != null)
                      ? CircleAvatar(
                          backgroundImage: AssetImage(channel.iconUrl!),
                        )
                      : Icon(Icons.chat),
                  title: Text(channel.name),
                  subtitle: Text("${channel.memberCount} Members"),
                  onTap: () {
                    // Navigate based on channel name
                    if (channel.name == "Google Dev") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  cchat())); // Replace MyWork with your actual destination widget
                    } else if (channel.name == "Apple Inc") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  cchat())); // Replace MyWork with your actual destination widget
                    }
                  },
                );
              },
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
