import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flux/dashboard.dart';

class myprofile extends StatelessWidget {
  const myprofile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.edit),
          )
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("asset/Ellipse 22.png"),
                  ),
                ),
                Positioned(
                  bottom: 5.0,
                  right: 5.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    radius: 12.0,
                    child: Icon(
                      Icons.edit,
                      size: 15.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            // Name, Age, Job section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "John Doe",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Age: 30",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Gender: Male",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(onPressed: () {}, child: Text("Chat")),
                ElevatedButton(onPressed: () {}, child: Text("Call")),
              ],
            ),
            Column(
              children: [
                Text("Graphic Designer",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "I'm a Digital Nomad. I've Been To Over 30 Countries In The Past 5 Years. I Love Hiking and Taking Photos."),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Icon(
                  Icons.star,
                  size: 20.0,
                  color: Colors.amber,
                ),
                Icon(
                  Icons.star,
                  size: 20.0,
                  color: Colors.amber,
                ),
                Icon(
                  Icons.star,
                  size: 20.0,
                  color: Colors.amber,
                ),
                Icon(
                  Icons.star,
                  size: 20.0,
                  color: Colors.amber,
                ),
                Icon(
                  Icons.star_half,
                  size: 20.0,
                  color: Colors.amber,
                ),
                SizedBox(width: 5.0),
                Text(
                  "4.8",
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.people),
                    SizedBox(width: 5),
                    Text("Member Since ",
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold)),
                  ],
                ),
                Text("2024")
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.pentagon_outlined),
                    SizedBox(width: 5),
                    Text("Ranking",
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold)),
                  ],
                ),
                Text("Master")
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => dashboard()));
                    },
                    child: Text("More")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
