import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flux/Electrician.dart';
import 'package:flux/channels.dart';
import 'package:flux/chat.dart';
import 'package:flux/cleaning.dart';
import 'package:flux/courier.dart';
import 'package:flux/drawer.dart';
import 'package:flux/fooddelivery.dart';
import 'package:flux/myprofile.dart';
import 'package:flux/profile.dart';
import 'package:flux/notification.dart';
import 'package:flux/plumbing.dart';
import 'package:flux/postatask.dart';
import 'package:flux/taxi.dart';
import 'package:flux/worknow.dart';

class service extends StatelessWidget {
  service({super.key});
  final List<String> categoryNames = [
    "Plumbing",
    "Electrician",
    "Taxi",
    "Courier",
    "Food Delivery",
    "Cleaning",
  ];

  final List<String> imageAssets = [
    "asset/pexels-toa-heftiba-şinca-1194420.jpg",
    "asset/pexels-toa-heftiba-şinca-1194420.jpg",
    "asset/pexels-toa-heftiba-şinca-1194420.jpg",
    "asset/pexels-toa-heftiba-şinca-1194420.jpg",
    "asset/pexels-toa-heftiba-şinca-1194420.jpg",
    "asset/pexels-toa-heftiba-şinca-1194420.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),
      appBar: AppBar(
        title: Text("FLUX"),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu));
        }),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage("asset/Ellipse 22.png"),
              child: InkWell(
                onTap: (() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => mine()));
                }),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(" Service Category"), 
                          IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => noti()),
                    );
                  },
                  icon: Icon(Icons.notifications_active_rounded))
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              itemCount: categoryNames.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.3,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    switch (index) {
                      case 0:
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => plumbing()),
                        );
                        break;
                      case 1:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => electrician()),
                        );
                        break;
                      case 2:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  taxi()), // Replace with your WorknowPage widget
                        );
                        break;
                      case 3:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Courier()), // Replace with your ServicesPage widget
                        );
                        break;
                      case 4:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  fooddelivery()), // Replace with your ServicesPage widget
                        );
                        break;
                      case 5:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  clean()), // Replace with your ServicesPage widget
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
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    imageAssets[index],
                                    scale: 1,
                                    width: 60,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            categoryNames[index],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>ptask()), // Replace with your ServicesPage widget
                    );
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  child: Text("Post Service")),
            ],
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
