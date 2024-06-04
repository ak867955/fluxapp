import 'package:flutter/material.dart';

class cprofile extends StatelessWidget {
  const cprofile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, // Go back
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    foregroundImage: AssetImage("asset/pexels-blitzboy-1040880.jpg"),
                    radius: 70,
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "John",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      SizedBox(height: 4),
                      Text("+91 9856345673",
                          style: TextStyle(color: Colors.grey[600])),
                      SizedBox(height: 4),
                      Text("Hey there! I am using Flux",
                          style: TextStyle(color: Colors.grey[600])),
                      SizedBox(height: 4),
                      Text("Your Relationship: Bestie",
                          style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ],
              ),
            ), 
            SizedBox(height: 40),
            Text(
              "My Mood",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text("Sleeping", style: TextStyle(fontSize: 16)),
            SizedBox(height: 40),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: Size(250, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {},
                    child: Text("Block"),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: Size(250, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {},
                    child: Text("Call"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
