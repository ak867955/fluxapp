import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class newchannel extends StatefulWidget {
  const newchannel({super.key});

  @override
  State<newchannel> createState() => _newchannelState();
}

class _newchannelState extends State<newchannel> {
  @override
  Widget build(BuildContext context) {
    int radiovalue = 0;

    void _handleRadioValueChanged(value) {
      setState(() {
        radiovalue = value;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("New channel"),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, // Go back
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text("Channel name"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 3),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 3),
                  ),
                  label: Text(
                    "e.g #team-tasks",
                    style: TextStyle(color: Colors.black),
                  )),
            ),
          ),
          Text("Description (optional)"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 3),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 3),
                  ),
                  label: Text(
                    "e.g A place to track our team tasks",
                    style: TextStyle(color: Colors.black),
                  )),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Radio(
                  value: 0,
                  groupValue: radiovalue,
                  onChanged: _handleRadioValueChanged),
              Row(
                children: [
                  Text("Private"),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Radio(
                  value: 1,
                  groupValue: radiovalue,
                  onChanged: _handleRadioValueChanged),
              Row(
                children: [
                  Text("Public"),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Text("Photo (optional)"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Upload photo"), Icon(Icons.camera_alt)],
          ),
          SizedBox(height: 10),
          Text("Payment (optional)"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Subscription fee"), Icon(Icons.currency_rupee)],
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: () {}, child: Text("Create"))
        ],
      ),
    );
  }
}
