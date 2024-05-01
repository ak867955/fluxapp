import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flux/secondpage.dart';

class page1 extends StatefulWidget {
  const page1({super.key});

  @override
  State<page1> createState() => _page1State();
}

class _page1State extends State<page1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => page2()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            // Set height to three-quarters of the screen size
            height: MediaQuery.of(context).size.height * 1,
            color: Colors.white,
            child: Stack(
              children: [
                // Image positioned at top with specified height
                Image.asset(
                  "asset/_35c9c348-f67d-4b85-ba1f-c88a7f4369a6.jpeg",
                  height: MediaQuery.of(context).size.height *
                      1, // Set image height to match container
                  fit: BoxFit.cover, // Ensure image covers the container
                ),
                // Text positioned absolutely with padding adjustment
              ],
            ),
          ),
        ],
      ),
    );
  }
}
