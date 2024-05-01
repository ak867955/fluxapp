import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class call extends StatelessWidget {
  const call({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calling"),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            height: 200,
            width: double.infinity,
            child: AspectRatio(
              aspectRatio: 4 / 1,
              child: Container(
                child: Image.asset(
                  "asset/Rectangle 73.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text("Jasmin", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius:
                          BorderRadius.circular(15), // Adjust as desired
                    ),
                    child: Center(
                        child: Text("00",
                            style:
                                TextStyle(color: Colors.white, fontSize: 50))),
                  ),
                  Center(
                      child: Text(
                    "Hours",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius:
                          BorderRadius.circular(15), // Adjust as desired
                    ),
                    child: Center(
                        child: Text("00",
                            style:
                                TextStyle(color: Colors.white, fontSize: 50))),
                  ),
                  Center(
                      child: Text(
                    "Minutes",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius:
                          BorderRadius.circular(15), // Adjust as desired
                    ),
                    child: Center(
                        child: Text("00",
                            style:
                                TextStyle(color: Colors.white, fontSize: 50))),
                  ),
                  Center(
                      child: Text(
                    "Seconds",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 50,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15), // Adjust as desired
                ),
                child: Center(
                    child: Text("Mute",
                        style: TextStyle(color: Colors.white, fontSize: 20))),
              ),
              SizedBox(height: 10),
              Container(
                height: 50,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15), // Adjust as desired
                ),
                child: Center(
                    child: Text("Speaker",
                        style: TextStyle(color: Colors.white, fontSize: 20))),
              ),
              SizedBox(height: 10),
              Container(
                height: 50,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15), // Adjust as desired
                ),
                child: Center(
                    child: Text("End call",
                        style: TextStyle(color: Colors.white, fontSize: 20))),
              ),
              SizedBox(height: 10),
            ],
          )
        ],
      ),
    );
  }
}
