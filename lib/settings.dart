import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flux/model/addressmodel.dart';
import 'package:flux/model/collection.dart';
import 'package:flux/model/myprofilemodel.dart';
import 'package:flux/feedback.dart';
import 'package:flux/utils/string.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key, required this.user, required this.address});

  Myprofilemodel? user;
  Addressmodel? address;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("My Account"),
              _buildListTile(
                context,
                title: "Phone Number",
                trailing:
                    TextButton(onPressed: () {}, child: Text(auth.currentUser!.phoneNumber.toString())),
              ),
              _buildListTile(
                context,
                title: "Profile Photo",
                trailing: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(widget.user!.url),
                ),
              ),
              _buildListTile(
                context,
                title: "Name",
                trailing: TextButton(
                    onPressed: () {},
                    child: Text(
                      widget.user!.firstname + widget.user!.secondname,
                    )),
              ),
              _buildSectionTitle("Location"),
              FutureBuilder<Addressmodel?>(
                future: Controller().getAddres(auth.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); 
                  }

                  if (snapshot.hasError) {
                    return Text(
                        'Error: ${snapshot.error}');  
                  }

                  final data = snapshot.data;
                  if (data == null) {
                    return Text(
                        'No data available');  
                  }

                  return _buildListTile(
                    context,
                    title: "My location",
                    trailing: TextButton(
                      onPressed: () {},
                      child: Text(data
                          .districts), 
                    ),
                  );
                },
              ),
              _buildSectionTitle("Support"),
              _buildListTile(
                context,
                title: "Contact Us",
                trailing:
                    TextButton(onPressed: () {}, child: Text("flux@gmail.com")),
              ),
              // _buildListTile(
              //   context,
              //   title: "Report a problem",
              //   trailing: IconButton(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => ChatPage()),
              //       );
              //     },
              //     icon: Icon(Icons.report),
              //   ),
              // ),
              // _buildListTile(
              //   context,
              //   title: "Feedback",
              //   trailing: IconButton(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => fb()),
              //       );
              //     },
              //     icon: Icon(Icons.help_center_outlined),
              //   ),
              // ),
              // _buildSectionTitle("Language"),
              // SizedBox(height: 20),
              // Center(
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     child: Text(
              //       "Log Out",
              //       style: TextStyle(fontWeight: FontWeight.bold),
              //     ),
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.black,
              //       minimumSize: Size(150, 50),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildListTile(BuildContext context,
      {required String title, Widget? trailing}) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          trailing: trailing,
        ),
        Divider(thickness: 1, color: Colors.grey[300]),
      ],
    );
  }
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Page'),
      ),
      body: Center(
        child: Text('Chat Page Content'),
      ),
    );
  }
}

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Page'),
      ),
      body: Center(
        child: Text('Feedback Page Content'),
      ),
    );
  }
}
