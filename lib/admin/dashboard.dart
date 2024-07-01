import 'package:flutter/material.dart';
import 'package:flux/admin/feedback.dart';
import 'package:flux/admin/overview.dart';
// import 'package:flux/admin/performance.dart';
import 'package:flux/admin/users.dart';
// import 'package:flux/drawer.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _ChannelsState();
}

class _ChannelsState extends State<AdminDashboard> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // drawer: drawer(),
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text("Overview", style: TextStyle(color: Colors.white)),
              ),
              Tab(
                child: Text("Users", style: TextStyle(color: Colors.white)),
              ),
              // Tab(
              //   child: Text("Fedback",style: TextStyle(color: Colors.white)),
              // ),
              // Tab(
              //   child:
              //       Text("Performance", style: TextStyle(color: Colors.white)),
              // ),
            ],
          ),
          title: Text("FLUX", style: TextStyle(color: Colors.white)),
          backgroundColor: Color.fromRGBO(8, 38, 76, 1),
          // leading: Builder(
          //   builder: (context) => IconButton(
          //     onPressed: () => Scaffold.of(context).openDrawer(),
          //     icon: Icon(Icons.menu,color: Colors.white),
          //   ),
          // ),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            Overview(), // Use the AllChannels widget directly
            Users(), // Use the MyChannels widget directly
            // AdminFeedback(),
            // Performance(),
          ],
        ),
      ),
    );
  }
}
