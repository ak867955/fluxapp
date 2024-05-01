import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flux/chat.dart';
import 'package:flux/flux.dart';

class page5 extends StatelessWidget {
  const page5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('asset/logo-black.png'),
                backgroundColor: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Profile Info",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 30),
            SizedBox(
              child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white70,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2), // Blue border
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2), // Blue border
                    ),
                    labelText: "Enter Your First Name",
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
                width: 360,
            ),
              SizedBox(height: 40),
            SizedBox(
              child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white70,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2), // Blue border
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2), // Blue border
                    ),
                    labelText: "Enter Your Second Name",
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
                width: 360,
            ),
            
              SizedBox(height: 25),
              Text(
                "By Signing Up , You Agree Terms Of Services",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context) => bottomnavipage(indexnum: 0,))));
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.send,
          color: Colors.black,
        ),
      ),
    );
  }
} 
