import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class application extends StatelessWidget {
  const application({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Application"),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CircleAvatar(
                      backgroundImage: AssetImage("asset/Ellipse 22.png"),
                      radius: 50),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Katherine",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text("Kochi , Ernakulam"),
                  SizedBox(height: 10),
                  Text("Beginner"),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Cover Letter",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text(
                    "I have been working on the design and development of websites for over 10 years. I can help you create a professional website that is easy to navigate and looks great. I am also experienced in SEO so I can make sure your site ranks well on Google.")
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text("Rate", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text("100 rs / hr"),
                  ],
                ),
                Column(
                  children: [
                    Text("Points", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text("50 Ps"),
                  ],
                ),
                Column(
                  children: [
                    Text("Timeline", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text("2 months"),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Text("Portfolio",style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 150,
                width: 150,
                child: Image.asset("asset/Rectangle 63.png"),
              ),
              Container(
                height: 150,
                width: 150,
                child: Image.asset("asset/Rectangle 64.png"),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: () {}, child: Text("Accept")),
              SizedBox(
                width: 20,
              ),
              TextButton(onPressed: () {}, child: Text("Contact")),
              SizedBox(
                width: 20,
              ),
              TextButton(onPressed: () {}, child: Text("Reject")),
            ],
          )
        ],
      ),
    );
  }
}
