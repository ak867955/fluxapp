import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class edchannel extends StatelessWidget {
  const edchannel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Channel"),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: Icon(Icons.arrow_back),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0), 
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 150,
                  child: Image.asset("asset/Rectangle 63.png"),
                ),
              ],
            ),
          ),
          Text(
            "Channel Name",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 10,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label:
                      Text("Enter Your Channel Name")),
            ),
          ),
          Text(
            "Username",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 10,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label:
                      Text("Enter Your Channel Userame")),
            ),
          ),
          Text(
            "About This Channel",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 10,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label:
                      Text("Enter About Your Channel")),
            ),
          ),

        Column(
          children: [
            Text("Channel Stats",style: TextStyle(fontWeight: FontWeight.bold),),
          ],
        ),
        ElevatedButton(onPressed: (){}, child: Text("Save"))
        ],

      
      ),
      
    );
  }
}
