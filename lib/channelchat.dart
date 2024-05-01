import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flux/channeldata.dart';
import 'package:flux/channelmenu.dart';
import 'package:flux/channeltabbar.dart';
import 'package:flux/profile.dart';

class cchat extends StatelessWidget {
  const cchat({super.key}); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => ctab()),
              );
            },
            child: Text("Design Team",style: TextStyle(color: Colors.white),)), // Replace with contact name or image
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(onPressed: () {Navigator.pop(context);}, // Go back
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage("asset/Ellipse 22.png"),
                            child: InkWell(
                onTap: (() {Navigator.push(context,MaterialPageRoute(builder: (context) => myprofile()));
                }),
              ),
            ),
          )
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              // Replace with your actual message data
              itemCount: 10, // Placeholder for message count
              itemBuilder: (context, index) =>
                  messageBubble(isSentByUser: index % 2 == 0),
            ),
          ),
          // Input field for sending messages
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget messageBubble({required bool isSentByUser}) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
            isSentByUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSentByUser)
            CircleAvatar(
              // User avatar (replace with your logic)
              child: Icon(Icons.person),
            ),
          SizedBox(width: 10),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: isSentByUser ? Colors.blue[200] : Colors.grey[200],
            ),
            child: Text("This is a message example."),
          ),
        ],
      ),
    );
  }
}
