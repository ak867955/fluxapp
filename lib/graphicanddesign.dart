import 'package:flutter/material.dart';
import 'package:flux/allchannels.dart';
import 'package:flux/channelaudio.dart';
import 'package:flux/channeldata.dart';
import 'package:flux/channelfile.dart';
import 'package:flux/channellinks.dart';
import 'package:flux/channelsearch.dart';
import 'package:flux/channelmenu.dart';
import 'package:flux/drawer.dart';
import 'package:flux/findtalent.dart';
import 'package:flux/findwork.dart';
import 'package:flux/mychannels.dart';
import 'package:flux/profile.dart';
import 'package:flux/worknowtabbar.dart';

class wtab extends StatefulWidget {
  const wtab({super.key});

  @override
  State<wtab> createState() => _ChannelsState();
}

class _ChannelsState extends State<wtab> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text("Find Works"),
              ),
              Tab(
                child: Text("Find Talents"),
              ),
            ],
          ),
          title: Text("FLUX"),
          backgroundColor: Color.fromRGBO(8, 38, 76, 1),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            }, // Go back
            icon: Icon(Icons.arrow_back_ios_new_outlined),
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
                    MaterialPageRoute(builder: (context) => myprofile()),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            fwork(), // Use the AllChannels widget directly
            ftalent(), // Use the MyChannels widget directly
          ],
        ),
      ),
    );
  }
} 
