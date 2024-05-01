import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class fb extends StatelessWidget {
  const fb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
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
          SizedBox(
            height: 5,
          ),
          AspectRatio(
            aspectRatio: 4 / 1,
            child: Container(
              child: Image.asset(
                "asset/logo-black.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
              "Your feedback is invaluable! It helps us continuously improve our app and provide the best possible experience for everyone. Please share your thoughts, suggestions, or concerns."),
          SizedBox(height: 10),
          Text("Comments", style: TextStyle(fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 10,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Description what you need")),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Attach file"), Icon(Icons.attach_file)],
          ),
          ElevatedButton(onPressed: () {}, child: Text("Submit Feedback")),
        ],
      ),
    );
  }
}
