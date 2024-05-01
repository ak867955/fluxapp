import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class workex extends StatelessWidget {
  const workex({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Your Work Experience"),
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
            child: TextField(
              maxLength: 10,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Enter your job title")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 10,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Enter your company name")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 10,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Enter your job description")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 10,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Enter your references")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 10,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Attach your previous job contracts")),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () {
              }, child: Text("Continue Later")),
              ElevatedButton(onPressed: () {}, child: Text("Done")),
            ],
          )
        ],
      ),
    );
  }
}
