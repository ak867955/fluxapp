import 'package:flutter/material.dart';
import 'package:flux/allchannels.dart';
import 'package:flux/findworks.dart';
import 'package:flux/myworks.dart';
import 'package:flux/channelsearch.dart';
import 'package:flux/profile.dart';
// import 'package:flux/chatopponentprofile.dart'; // Import your ChatOpponentProfile page
import 'package:flux/model/myprofilemodel.dart'; // Import your Myprofilemodel class

class worknowcategories extends StatefulWidget {
  final String selectedCategory;
  final Myprofilemodel senderProfileModel; // Add senderProfileModel parameter

  worknowcategories({
    super.key,
    required this.selectedCategory,
    required this.senderProfileModel, // Add required parameter
  });

  @override
  State<worknowcategories> createState() => _ChannelsState();
}

class _ChannelsState extends State<worknowcategories> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text("My Works", style: TextStyle(color: Colors.white)),
              ),
              Tab(
                child: Text("Find Works", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          title: const Text("FLUX", style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromRGBO(8, 38, 76, 1),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            }, // Go back
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          actions: [
            // IconButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => csearch()),
            //     );
            //   },
            //   icon: const Icon(Icons.search, color: Colors.white),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0), 
            //   child: CircleAvatar(
            //     backgroundImage: const AssetImage("asset/Ellipse 22.png"),
            //     child: InkWell(
            //       onTap: () => Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => ChatOpponentProfile(
            //             opponentProfileModel: widget.senderProfileModel,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
        body: TabBarView(
          children: [
            MyWorks(selectedCategory: widget.selectedCategory), // Use the AllChannels widget directly
            FindWorks(selectedCategory: widget.selectedCategory), // Use the MyChannels widget directly
          ],
        ),
      ),
    );
  }
}
