import 'package:flutter/material.dart';
import 'package:flux/application.dart';

class Message {
  final String name;
  final String? iconUrl;
  final String days;

  const Message({required this.name, this.iconUrl, required this.days});
}

class smess extends StatefulWidget {
  const smess({Key? key}) : super(key: key);

  @override
  State<smess> createState() => _smessState();
}

class _smessState extends State<smess> {
  @override
  Widget build(BuildContext context) {
    final List<Message> channels = [
      Message(
          name: "Design by Sarah",
          iconUrl: "asset/Ellipse 9.png",
          days: "1 day ago"),
      Message(
          name: "Car Wash by John",
          iconUrl: "asset/Ellipse 9.png",
          days: "2 days ago"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Saved Messages",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: Colors.white,),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search,color: Colors.white,),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: channels.length,
          itemBuilder: (context, index) {
            final channel = channels[index];
            return GestureDetector(
                    onTap: () {
        // Navigate to chat page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => application()),
        );
      },
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: channel.iconUrl != null
                        ? AssetImage(channel.iconUrl!)
                        : null,
                    child: channel.iconUrl == null
                        ? Icon(Icons.chat, size: 30)
                        : null,
                  ),
                  title: Text(
                    channel.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    channel.days,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
