import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class profile extends StatelessWidget {
  const profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new_outlined)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Create Your Profile",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Name",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLength: 10,
                decoration: InputDecoration(border: OutlineInputBorder(),
                label: Text("Tell clients about yourself and what you do best")
                ),
                
              ),
            ),
            // SizedBox(height: 10,),
            Text(
              "About me",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLength: 10,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            //SizedBox(height: 10,),
            Text(
              "Skill",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLength: 10,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            Text(
              "Qualification",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLength: 10,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            Text(
              "Experience",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: 
              TextField(
                maxLength: 10,
                decoration: InputDecoration(border: OutlineInputBorder()),
                
              ),
              
            ),
          ],
        ),
      ),
    );
  }
}
