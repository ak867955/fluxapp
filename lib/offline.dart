import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class offline extends StatelessWidget {
  const offline({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FLUX",style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: Icon(Icons.arrow_back_ios_new_outlined),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center content vertically
          children: [
            Image.asset(
              "asset/Rectangle 112.png", // Replace with your offline icon
              height: 300.0,
              width: 200, // Adjust icon size as needed
            ),
            const SizedBox(height: 20.0), // Add spacing between icon and text
            Text(
              "You're Offline",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0), // Add spacing between text lines
            Text(
              "Please check your internet connection and try again.",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20.0), // Add spacing before button
            ElevatedButton(
              onPressed: () {},
              child: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(23, 42, 89, 1),
                minimumSize: Size(200, 50), // Set desired width and height
              ),
            ),
          ],
        ),
      ),
    );
  }
}
