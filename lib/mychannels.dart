import 'package:flutter/material.dart';
import 'package:flux/channelchat.dart';
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
    final List<Channel> channels = [
      Channel(
          name: "Flutter Dev",
          iconUrl: "asset/Rectangle 59.png",
          memberCount: 1000),
      Channel(
          name: "Samsung Inc", 
          iconUrl: "asset/Rectangle 59.png",
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
                    if (channel.name == "Flutter Dev") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  cchat())); // Replace MyWork with your actual destination widget
                    } else if (channel.name == "Samsung Inc") {
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
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          newchannel()), // Replace with your ChatPage widget
                );
              },
              child: Text("Create Channel")),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
