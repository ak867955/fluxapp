import 'package:flutter/material.dart';
import 'package:flux/allchannels.dart';
import 'package:flux/channelsearch.dart';
import 'package:flux/drawer.dart';
import 'package:flux/mychannels.dart';
import 'package:flux/myprofile.dart';
import 'package:flux/profile.dart';

class channels extends StatefulWidget {
  const channels({super.key});
 
  @override
  State<channels> createState() => _ChannelsState();
}

class _ChannelsState extends State<channels> {
  int selectedTab = 0; // Initial selected tab (All Channels)

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: drawer(),
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text("All Channels"),
              ),
              Tab(
                child: Text("My Channels"),
              ),
            ],
          ),
          title: Text("FLUX"),
          backgroundColor: Color.fromRGBO(8, 38, 76, 1),
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icon(Icons.menu),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => csearch()));
                },
                icon: Icon(Icons.search)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage("asset/Ellipse 22.png"),
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => mine()),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            allchannel(), // Use the AllChannels widget directly
            mychannels(), // Use the MyChannels widget directly
          ],
        ),
      ),
    );
  }
}
