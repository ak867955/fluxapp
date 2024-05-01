import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class panveri extends StatelessWidget {
  const panveri({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verification"),
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
          Text(  
            "Get verified to access all features",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Get verified to access all features Complete your verification to access all of our platform's features."
            "This is required for monetization and payouts.",
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Account status",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text("Unverified"),
          SizedBox(
            height: 10,
          ),
          Text(
            "What we need from you",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("Pan Card Number"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 10,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Enter Your Pan Card Number")),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Pan Card Image"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Upload Pan Card Image")),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: () {}, child: Text("Start Verification"))
        ],
      ),
    );
  }
}
