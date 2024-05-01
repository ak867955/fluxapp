import 'package:flutter/material.dart';

class videocall extends StatelessWidget {
  const videocall({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Match background color
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white, // White for better visibility
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.black,
            child: Center(
              child: Icon(
                Icons.videocam,
                color: Colors.white,
                size: 100,
              ),
            ),
          ),
          // Caller image overlay
          Positioned(
            top: 50,
            right: 20,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage("asset/Ellipse 9.png"),
            ),
          ),
          // Call controls (inactive for now)
          Positioned(
            bottom: 50,
            left: MediaQuery.of(context).size.width / 2.5 - 25,
            child: Row(
              children: [
                // Mute button (inactive)
                IconButton(
                  onPressed: () {}, // Add functionality later
                  icon: Icon(
                    Icons.mic_off,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                SizedBox(width: 20),
                // End call button (inactive)
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  }, // Add functionality later
                  icon: Icon(
                    Icons.call_end,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
