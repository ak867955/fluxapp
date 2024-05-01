import 'package:flutter/material.dart';
import 'package:flux/calling.dart';
import 'package:flux/channelchat.dart';
import 'package:flux/chatpage.dart';

class ServicePost {
  final String avatarUrl;
  final String serviceName;
  final String imageUrl;
  final String price;
  final String time;
  final String serviceDetails;

  const ServicePost({
    required this.avatarUrl,
    required this.serviceName,
    required this.imageUrl,
    required this.price,
    required this.time,
    required this.serviceDetails,
  });
}

class fooddelivery extends StatelessWidget {
  const fooddelivery({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ServicePost> posts = [
      ServicePost(
        avatarUrl: "asset/Ellipse 8.png",
        serviceName: "Plumber",
        imageUrl: "asset/Rectangle 72.png",
        price: "300",
        time: "1 Hr",
        serviceDetails:
            "Post details: I take pride in my work, ensuring your home is spotless and comfortable. Flexible scheduling available.",
      ),
      ServicePost(
        avatarUrl: "asset/Ellipse 8.png",
        serviceName: "Plumber",
        imageUrl: "asset/Rectangle 73.png",
        price: "500",
        time: "1 Hr",
        serviceDetails:
            "Post details: I take pride in my work, ensuring your home is spotless and comfortable. Flexible scheduling available.",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        actions: [Icon(Icons.search_rounded)],
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start, // Align top
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(post.avatarUrl),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              post.serviceName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Spacer(), // Add Spacer to push price & time to right
                            Text(post.time),
                            SizedBox(width: 5),
                            Text(post.price),
                          ],
                        ),
                        SizedBox(height: 5),
                        Image.asset(post.imageUrl, height: 100),
                        SizedBox(height: 5),
                        Text(post.serviceDetails),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => chatpage()));
                                ;
                              },
                              icon: Icon(Icons.chat),
                              label: Text("Chat"),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => call()));
                              },
                              icon: Icon(Icons.call),
                              label: Text("Call"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
