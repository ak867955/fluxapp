import 'package:flutter/material.dart';
import 'package:flux/channels.dart';
import 'package:flux/channelsearch.dart';
import 'package:flux/chatpage.dart';
import 'package:flux/chatsearch.dart';
import 'package:flux/drawer.dart';
import 'package:flux/myprofile.dart';
import 'package:flux/profile.dart';
import 'package:flux/createprofile.dart';
import 'package:flux/service.dart';
import 'package:flux/worknow.dart';

class chat extends StatelessWidget {
  const chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),
      appBar: AppBar(
        title: Text("FLUX"),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
              Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu),
            );
          }
        ),
        actions: [
          IconButton(onPressed: () {
           Navigator.push(context,MaterialPageRoute(builder: (context) => chatsearch()));
          }, icon: Icon(Icons.search)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("asset/Ellipse 22.png"),
              child: InkWell(
                onTap: (() {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => mine()));
                }),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 20, // Number of items in the list
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("PERSON $index"),
              subtitle: Text("Message $index"),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(
                    "asset/Ellipse 22.png"), // Replace with your asset path
              ),
              trailing: Text("1$index:00 PM"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          chatpage()), // Replace with your ChatPage widget
                );
              },
            );
          },
        ),
      ),
    );
  }
}
