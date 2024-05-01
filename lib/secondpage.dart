import 'package:flutter/material.dart';
import 'package:flux/auth/phonenumber.dart';
import 'package:flux/otppage.dart';

class page2 extends StatelessWidget {
  const page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center, // Center both content and image
        height: double.infinity, // Fill the entire screen
        color: Colors.white,
        child: Column(
          // Use Stack to position image and content
          children: [
            Positioned(
              // Position image half-screen height from top
              top: MediaQuery.of(context).size.height / 3,
              left: 0,
              right: 0,
              child: ClipRRect(
                // Clip image to make bottom part circular
                child: Image.asset(
                  "asset/_8f030a05-db5c-4987-8dfe-47001c2bab99.jpeg",
                  fit: BoxFit
                      .cover, // Fill container while maintaining aspect ratio
                ),
              ),
            ),
            Positioned(
              // Position text and button below the image
              bottom: 30, // Adjust spacing as needed
              left: 20,
              right: 20,
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Welcome to ",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        TextSpan(
                          text: "Flux",
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                        TextSpan(
                          text:
                              " Forget Limitations. Forget Juggling Multiple Apps. Flux Isn't your Average Communication Tool. It's a Supercharged Experience Designed To Simplify And Empower Your Everyday Life.",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center, // Center text horizontally
                  ),
                  SizedBox(height: 70),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) => pnumber())));
                    },
                    child: Text(
                      "Let's Go",
                      style: TextStyle(fontSize: 30),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(23, 42, 89, 1),
                        minimumSize: Size(200, 80)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
