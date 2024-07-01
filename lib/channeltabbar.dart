import 'package:flutter/material.dart';
import 'package:flux/allchannels.dart';
import 'package:flux/channelaudio.dart';
import 'package:flux/channeldata.dart';
import 'package:flux/channelfile.dart';
import 'package:flux/channellinks.dart';
import 'package:flux/channelsearch.dart';
import 'package:flux/channelmenu.dart';
import 'package:flux/model/myprofilemodel.dart';
import 'package:flux/model/newchannelmodel.dart';
import 'package:flux/drawer.dart';
import 'package:flux/mychannels.dart';
import 'package:flux/profile.dart';

class ctab extends StatefulWidget {
    ChannelModel channelModel;
    final Myprofilemodel senderProfileModel; 

   ctab({super.key,required this.channelModel,required this.senderProfileModel,});

  @override
  State<ctab> createState() => _ChannelsState();
}

class _ChannelsState extends State<ctab> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar( 
            tabs: [
              const Tab(
                child: Text("About",style: TextStyle(color: Colors.white)),
              ),
              // Tab(
              //   child: Text("Files",style: TextStyle(color: Colors.white)),
              // ),
              // Tab(
              //   child: Text("Audio",style: TextStyle(color: Colors.white)),
              // ),
              // Tab(
              //   child: Text("Links",style: TextStyle(color: Colors.white)),
              // ),
            ],
          ),
          title: const Text("FLUX",style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromRGBO(8, 38, 76, 1),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            }, // Go back
            icon: const Icon(Icons.arrow_back,color: Colors.white),
          ),
          actions: [ 
            // IconButton(
            //     onPressed: () {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => csearch()));
            //     },
            //     icon: const Icon(Icons.search,color: Colors.white)),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: CircleAvatar(
            //     backgroundImage: const AssetImage("asset/Ellipse 22.png"),
            //     child: InkWell(
            //       onTap: () => Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) =>  ChatOpponentProfile( opponentProfileModel: widget.senderProfileModel,)),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
        body: TabBarView(
          children: [
             cmenu(channelModel: widget.channelModel,), // Use the AllChannels widget directly
            // cfile(), // Use the MyChannels widget directly
            // caudio(),
            // clink(),
          ],
        ),
      ),
    );
  }
}
