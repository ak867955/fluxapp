import 'package:flutter/material.dart';
import 'package:flux/calling.dart';
import 'package:flux/chatpage.dart';
import 'package:flux/createprofile.dart';
import 'package:flux/dashboard.dart';

class profile extends StatefulWidget {
  const profile({super.key});
 
  @override 
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back,color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("asset/pexels-blitzboy-1040880.jpg"),
            ),
            const SizedBox(height: 20),
            Text(
              "John Doe",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Graphic Designer",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.cake, color: Colors.black54),
                SizedBox(width: 5),
                Text(
                  "Age: 30",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(width: 20),
                Icon(Icons.male, color: Colors.black54),
                SizedBox(width: 5),
                Text(
                  "Gender: Male",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "I'm a Digital Nomad. I've Been To Over 30 Countries In The Past 5 Years. I Love Hiking and Taking Photos.",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()));
                  },
                  icon: const Icon(Icons.chat),
                  label: const Text("Chat"),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => call()));
                  },
                  icon: const Icon(Icons.call),
                  label: const Text("Call"),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const Icon(Icons.star, color: Colors.amber),
                const Icon(Icons.star, color: Colors.amber),
                const Icon(Icons.star, color: Colors.amber),
                const Icon(Icons.star_half, color: Colors.amber),
                const SizedBox(width: 5),
                Text(
                  "4.8",
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text(
                "Member Since",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Text("2024"),
            ),
            ListTile(
              leading: const Icon(Icons.pentagon_outlined),
              title: const Text(
                "Ranking",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Text("Master"),
            ),
            const Spacer(),
            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => dashboard()));
            //     },
            //     child: const Text("More"),
            //     style: ElevatedButton.styleFrom(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
