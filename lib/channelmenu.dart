import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Member {
  final String name;
  final String imageUrl; // Assuming you have an image URL for each member
  final DateTime lastSeen; 
 
  const Member(
      {required this.name, required this.imageUrl, required this.lastSeen});
}
 
class cmenu extends StatelessWidget {
  const cmenu({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Member> members = [
      Member(
          name: "Michael",
          imageUrl: "assets/avatar1.png",
          lastSeen: DateTime.now().subtract(Duration(hours: 2))),
      Member(
          name: "Sarah",
          imageUrl: "assets/avatar2.png",
          lastSeen: DateTime.now().subtract(Duration(days: 1))),
      Member(
          name: "John",
          imageUrl: "assets/avatar2.png",
          lastSeen: DateTime.now().subtract(Duration(days: 1))),
      Member(
          name: "Tom",
          imageUrl: "assets/avatar2.png",
          lastSeen: DateTime.now().subtract(Duration(days: 1))),
      // Add more members...
    ];

    return Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: 150,
                  child: Image.asset("asset/Rectangle 63.png"),
                ),
                Text(
                  "Design Team",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text("Design Community"),
                SizedBox(height: 5),
                Text("1.2 M Subscriber"),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Colors.blueAccent), // Change color to blue accent
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Set corner radius to 20
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(
                      Size(150, 50)), // Set width and height
                ),
                child: Text("Subscribe"),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Colors.black), // Change color to blue accent
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Set corner radius to 20
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(
                      Size(150, 50)), // Set width and height
                ),
                child: Text("Share"),
              ),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("About This Channel",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text(
                    "The latest UI/UX Design News And Information On Projects"),
                SizedBox(height: 10),
                Row(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage("asset/Ellipse 22.png"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text("Michael"),
                              Text("Owner"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Subscribers",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: members.length,
              itemBuilder: (context, index) {
                final member = members[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(member.imageUrl),
                  ),
                  title: Text(member.name),
                  subtitle: Text(getLastSeenText(member.lastSeen)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
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
