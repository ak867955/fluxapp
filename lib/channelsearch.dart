import 'package:flutter/material.dart';
import 'package:flux/channelchat.dart';
import 'package:flux/findwork.dart';
import 'package:flux/profile.dart'; // Assuming panveri.dart is your target screen

class csearch extends StatelessWidget {
  csearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FLUX"),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage("asset/Ellipse 22.png"),
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => myprofile()),
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Search"),
              ),
            ),
          ), 
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
              itemCount: 6,
              itemBuilder: (context, index) => WorkCard(
                title: "Channel Title $index",
                description: "This is a sample work description.",
                imageUrl: "asset/pexels-toa-heftiba-şinca-1194420.jpg",
                onTap: () {
                  switch (index) {
                    case 0:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => cchat()),
                      );
                      break;
                      break;
                    case 1:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => cchat()),
                      );
                      break;
                    case 2:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => cchat()),
                      );
                      break;
                    case 3:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => cchat()),
                      );
                      break;
                    case 4:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => cchat()),
                      );
                      break;
                    case 5:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => cchat()),
                      );
                      break;

                    default:
                    // Handle other cases (optional)
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WorkCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final VoidCallback? onTap; // Added onTap callback

  const WorkCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Wrap with InkWell for tap detection
      onTap: onTap,
      child: Card( 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5),
            Text(title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(description, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
