import 'package:flutter/material.dart';
import 'package:flux/profile.dart';

class wworks extends StatelessWidget {
  wworks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            // Allow GridView to expand within available space
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two columns
                crossAxisSpacing: 10, // Spacing between columns
                mainAxisSpacing: 10, // Spacing between rows
              ),
              itemCount: 10, // Replace with your actual data length
              itemBuilder: (context, index) => WorkCard(
                title: "Work Title $index",
                description: "This is a sample work description.",
                imageUrl:
                    "asset/Rectangle 63.png", // Replace with your actual image URLs
              ),
            ),
          )
        ],
      ),
    );
  }
}

class WorkCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const WorkCard(
      {super.key,
      required this.title,
      required this.description,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                height: 100,
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5),
            Text(title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(description, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
