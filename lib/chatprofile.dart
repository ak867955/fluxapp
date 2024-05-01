import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class cprofile extends StatelessWidget {
  const cprofile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, // Go back
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  foregroundImage: AssetImage("asset/Ellipse 8.png"),
                  radius: 70,
                ),
                SizedBox(
                  width: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("John", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("+91 9856345673"),
                    Text("Hey there ! I am using Flux"),
                    Text("Your Relationship : Bestie"),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Column(
            // Add crossAxisAlignment: CrossAxisAlignment.start
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Mood",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text("Sleeping"),
            ],
          ),
          SizedBox(height: 20),
          Column(
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: Size(250, 50)),
                  onPressed: () {},
                  child: Text("Message")),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, minimumSize: Size(250, 50)),
                  onPressed: () {},
                  child: Text("Call")),
            ],
          )
        ],
      ),
    );
  }
}
