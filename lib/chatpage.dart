import 'package:flutter/material.dart';
import 'package:flux/chatprofile.dart';
import 'package:flux/createprofile.dart';
import 'package:flux/videocall.dart';

class chatpage extends StatelessWidget {
  const chatpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => cprofile()));
            },
            child: Text(
              "Lilly",
              style: TextStyle(color: Colors.white),
            )), // Replace with contact name or image
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          videocall()), // Replace with your ServicesPage widget
                );
              },
              icon: Icon(Icons.video_call_outlined)),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Chat messages list (replace with actual data fetching/display logic)
          Expanded(
            child: ListView.builder(
              reverse: true, // Display newest messages at the top
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return _buildMessage(message);
              },
            ),
          ),
          // Chat input bar
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border(top: BorderSide(color: Colors.grey[400]!)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.attach_file),
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

  Widget _buildMessage(Message message) {
    final isMe = message.sender == "Me";
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: isMe ? Colors.blue[100] : Colors.grey[200],
        ),
        child: Text(message.text),
      ),
    );
  }
}

class Message {
  final String sender;
  final String text;

  Message({required this.sender, required this.text});
}

// Sample messages (replace with actual data fetching logic)
List<Message> messages = [
  Message(sender: "Lilly", text: "Hi! How are you?"),
  Message(sender: "Me", text: "Hey, I'm doing well. What about you?"),
  Message(sender: "Lilly", text: "Great! What are you up to today?"),
  // Add more messages...
];
void _showAttachmentMenu(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => Container(
          height: 200.0,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () {
                // Implement gallery option (e.g., using image_picker)
                print('Gallery selected');
              },
            ),
            ListTile(
              leading: Icon(Icons.videocam),
              title: Text('Video'),
              onTap: () {
                // Implement video option (e.g., using video_player)
                print('Video selected');
              },
            ),
            ListTile(
              leading: Icon(Icons.videocam),
              title: Text('Audio'),
              onTap: () {
                // Implement video option (e.g., using video_player)
                print('Audio selected');
              },
            ),
            ListTile(
              leading: Icon(Icons.videocam),
              title: Text('Pay'),
              onTap: () {
                // Implement video option (e.g., using video_player)
                print('Pay selected');
              },
            ),
          ])));
}
