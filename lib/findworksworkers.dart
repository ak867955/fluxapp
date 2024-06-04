import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flux/myprofile.dart';
import 'package:flux/profile.dart';

class fworkers extends StatefulWidget {
  const fworkers({super.key});

  @override
  State<fworkers> createState() => _fworkersState();
}

class _fworkersState extends State<fworkers> {

    final List<String> categoryNames = [
    "Name",
    "Name",
    "Name",
    "Name",
    "Name",
    "Name",
    "Name",
    "Name",
    "Name",
    "Name",
  ];

  final List<String> imageAssets = [
    "asset/Ellipse 8.png",
    "asset/Ellipse 8.png",
    "asset/Ellipse 8.png",
    "asset/Ellipse 8.png",
    "asset/Ellipse 8.png",
    "asset/Ellipse 8.png",
    "asset/Ellipse 8.png",
    "asset/Ellipse 8.png",
    "asset/Ellipse 8.png",
    "asset/Ellipse 8.png",
  ];

  final List<String> description = [
    "Simple Description",
    "Simple Description",
    "Simple Description",
    "Simple Description",
    "Simple Description",
    "Simple Description",
    "Simple Description",
    "Simple Description",
    "Simple Description",
    "Simple Description",
  ];
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
      body: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            // Allow GridView to expand within available space
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two columns
                  crossAxisSpacing: 10, // Spacing between columns
                  mainAxisSpacing: 10, // Spacing between rows
                ),
                itemCount: categoryNames
                    .length, // Replace with your actual data length
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      switch (index) {
                        case 0:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => profile()),
                          );
                          break;
                        case 1:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => profile()),
                          );
                          break;
                        case 2:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    profile()), // Replace with your WorknowPage widget
                          );
                          break;
                        case 3:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    profile()), // Replace with your ServicesPage widget
                          );
                          break;
                        case 4:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    profile()), // Replace with your ServicesPage widget
                          );
                          break;
                        case 5:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    profile()), // Replace with your ServicesPage widget
                          );
                          break;
                        case 6:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    profile()), // Replace with your ServicesPage widget
                          );
                          break;
                        case 7:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    profile()), // Replace with your ServicesPage widget
                          );
                          break;
                        case 8:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    profile()), // Replace with your ServicesPage widget
                          );
                          break;
                        case 9:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    profile()), // Replace with your ServicesPage widget
                          );
                          break;
                      }
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  imageAssets[index],
                                  scale: 1,
                                  width: 100,
                                ),
                              ),
                            ),
                            Text(
                              categoryNames[index],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              description[index],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
