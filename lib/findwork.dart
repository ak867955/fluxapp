import 'package:flutter/material.dart';
import 'package:flux/application.dart';
import 'package:flux/findtalent.dart';
import 'package:flux/findworksworkers.dart';
import 'package:flux/profile.dart';

class fwork extends StatefulWidget {
  fwork({super.key});

  @override
  State<fwork> createState() => _fworkState();
}

class _fworkState extends State<fwork> {
  final List<String> categoryNames = [
    "Title",
    "Title",
    "Title",
    "Title",
    "Title",
    "Title",
  ];

  final List<String> imageAssets = [
    "asset/Rectangle 73.png",
    "asset/Rectangle 73.png",
    "asset/Rectangle 73.png",
    "asset/Rectangle 73.png",
    "asset/Rectangle 73.png",
    "asset/Rectangle 73.png",
  ];

  final List<String> description = [
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
                                builder: (context) => fworkers()),
                          );
                          break;
                        case 1:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => fworkers()),
                          );
                          break;
                        case 2:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    fworkers()), // Replace with your WorknowPage widget
                          );
                          break;
                        case 3:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    fworkers()), // Replace with your ServicesPage widget
                          );
                          break;
                        case 4:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    fworkers()), // Replace with your ServicesPage widget
                          );
                          break;
                        case 5:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    fworkers()), // Replace with your ServicesPage widget
                          );
                          break;
                        case 6:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    fworkers()), // Replace with your ServicesPage widget
                          );
                          break;
                        case 7:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    fworkers()), // Replace with your ServicesPage widget
                          );
                          break;
                        case 8:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    fworkers()), // Replace with your ServicesPage widget
                          );
                          break;
                        case 9:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    fworkers()), // Replace with your ServicesPage widget
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
