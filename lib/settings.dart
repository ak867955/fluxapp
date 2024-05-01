import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flux/chatpage.dart';
import 'package:flux/feedback.dart';

class settings extends StatelessWidget {
  const settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customeText(
                  "My Account",
                  fontweight: FontWeight.bold,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customeText(
                  "Phone Number",
                ),
                TextButton(onPressed: () {}, child: Text("9856743859")),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customeText(
                  "Profile Photo",
                ),
                Icon(
                  Icons.navigate_next_rounded,
                  color: Colors.black,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customeText(
                  "Name",
                ),
                TextButton(onPressed: () {}, child: Text("9856743859")),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customeText(
                  "Privacy & Security",
                  fontweight: FontWeight.bold,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customeText(
                  "See my location",
                ),
                TextButton(onPressed: () {}, child: Text("Everyone")),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customeText(
                  "Contact me",
                ),
                TextButton(onPressed: () {}, child: Text("Everyone")),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customeText(
                  "Support",
                  fontweight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customeText(
                  "Help Center",
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              chatpage()), // Replace with your ServicesPage widget
                    );
                  }, // Go back
                  icon: Icon(Icons.task_alt),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customeText(
                  "Report a problem",
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              chatpage()), // Replace with your ServicesPage widget
                    );
                  }, // Go back
                  icon: Icon(Icons.report),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customeText(
                  "Feedback",
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              fb()), // Replace with your ServicesPage widget
                    );
                  }, // Go back
                  icon: Icon(Icons.help_center_outlined),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customeText(
                  "Language",
                  fontweight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Log Out",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ))
          ],
        ),
      ),
    );
  }

  Widget customeText(String text, {FontWeight? fontweight}) {
    return Text(text,
        style: TextStyle(
            color: Colors.black, fontWeight: fontweight ?? FontWeight.normal));
  }
}
