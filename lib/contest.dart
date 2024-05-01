import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class cont extends StatelessWidget {
  cont({super.key});
  final List<String> contestTitles = [
    "Design a Logo for a clothing brand",
    "Develop a mobile app for a food delivery service",
    "Write a creative blog post on social media marketing",
  ];

  final List<String> contestDescriptions = [
    "We're looking for a logo that's simple and modern. Our company name is 'Wardrobe'",
    "The app should be user-friendly and efficient for both customers and restaurants.",
    "The blog post should be informative and engaging for a target audience of business owners.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contest Details"),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined)),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                "Create",
                style: TextStyle(color: Colors.white),
              ))
        ],
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: contestTitles.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 4 / 2,
                    child: Container(
                      child: Image.asset(
                        "asset/Rectangle 73.png", // Replace with your contest image asset
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    contestTitles[index],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(contestDescriptions[index]),
                  // Add more details about the contest if needed
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: () {}, child: Text("Apply")),
                      ElevatedButton(onPressed: () {}, child: Text("Save")),
                      ElevatedButton(onPressed: () {}, child: Text("View")),
                    ],
                  ),
                  SizedBox(height: 10),
  
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
