import 'dart:math';
import 'package:flutter/material.dart';

class AdminFeedback extends StatefulWidget {
  AdminFeedback({super.key});

  @override
  State<AdminFeedback> createState() => _dusersState();
}

class _dusersState extends State<AdminFeedback> {
  final List<String> feedbackOptions = [
    'App is good',
    'App is bad',
    'Needs improvement',
    'Excellent!',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40),
          SizedBox(
            width: 900,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black, width: 3),
                ),
                label: Text(
                  "Search",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6, // 3 cards per row
                mainAxisSpacing: 10, // spacing between rows
                crossAxisSpacing: 10, // spacing between columns
              ),
              itemCount: 12, // 12 cards
              itemBuilder: (context, index) {
                final randomFeedback =
                    feedbackOptions[Random().nextInt(feedbackOptions.length)];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage("assets/Ellipse 22.png"),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "User ${index + 1}", // Display user name (User 1-12)
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          randomFeedback,
                          style: TextStyle(color: Colors.teal),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
