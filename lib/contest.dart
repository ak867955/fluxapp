import 'package:flutter/material.dart';
import 'package:flux/application.dart';
import 'package:flux/postacontest.dart';
import 'package:flux/savedmessage.dart';

class cont extends StatefulWidget {
  cont({super.key});

  @override
  State<cont> createState() => _contState();
}

class _contState extends State<cont> {
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
        title: Text("Contest Details", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => pcont()));
            },
            child: Text(
              "Create",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: contestTitles.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
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
                        ElevatedButton(
                          onPressed: () {
                            _showSnackBar(context, "Successfully Applied!");
                            // Navigate to the application screen
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => Application()));
                          },
                          child: Text("Apply"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _showSnackBar(context, "Contest Saved!");
                            // Navigate to the saved message screen
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => SavedMessage()));
                          },
                          child: Text("Save"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to the application screen
                            Navigator.push(context, MaterialPageRoute(builder: (context) => application()));
                          },
                          child: Text("View"),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
