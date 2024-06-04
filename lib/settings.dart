import 'package:flutter/material.dart';
import 'package:flux/chatpage.dart';
import 'package:flux/feedback.dart';

class settings extends StatelessWidget {
  const settings({super.key});

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
          icon: Icon(Icons.arrow_back,color: Colors.white),
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
                trailing: TextButton(onPressed: () {}, child: Text("9856743859")),
              ),
              _buildListTile(
                context,
                title: "Profile Photo",
                trailing: Icon(Icons.navigate_next_rounded, color: Colors.black),
              ),
              _buildListTile(
                context,
                title: "Name",
                trailing: TextButton(onPressed: () {}, child: Text("Jack")),
              ),
              _buildSectionTitle("Privacy & Security"),
              _buildListTile(
                context,
                title: "See my location",
                trailing: TextButton(onPressed: () {}, child: Text("Everyone")),
              ),
              _buildListTile(
                context,
                title: "Contact me",
                trailing: TextButton(onPressed: () {}, child: Text("Everyone")),
              ),
              _buildSectionTitle("Support"),
              _buildListTile(
                context,
                title: "Help Center",
                trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatPage()),
                    );
                  },
                  icon: Icon(Icons.task_alt),
                ),
              ),
              _buildListTile(
                context,
                title: "Report a problem",
                trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatPage()),
                    );
                  },
                  icon: Icon(Icons.report),
                ),
              ),
              _buildListTile(
                context,
                title: "Feedback",
                trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => fb()),
                    );
                  },
                  icon: Icon(Icons.help_center_outlined),
                ),
              ),
              _buildSectionTitle("Language"),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Log Out",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: Size(150, 50),
                  ),
                ),
              ),
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
