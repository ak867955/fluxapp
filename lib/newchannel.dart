import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flux/addmemebers.dart';
import 'package:flux/collection/collection.dart';
import 'package:flux/collection/newchannelmodel.dart';
import 'package:flux/data/channel_controller.dart';

class NewChannelPage extends StatefulWidget {
  const NewChannelPage({super.key});

  @override
  State<NewChannelPage> createState() => _NewChannelPageState();
}

class _NewChannelPageState extends State<NewChannelPage> {
  final _formKey = GlobalKey<FormState>();
  final namecontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();
  final typecontroller = TextEditingController(text: "Private");
  final paymentcontroller = TextEditingController();
  String? selectedCategory;
  int radiovalue = 0;

  void _handleRadioValueChanged(int? value) {
    setState(() {
      radiovalue = value!;
      if (radiovalue == 0) {
        typecontroller.text = "Private";
      } else if (radiovalue == 1) {
        typecontroller.text = "Public";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Channel", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("asset/Ellipse 20.png"),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          radius: 20,
                          child: IconButton(
                            icon:
                                Icon(Icons.edit, size: 20, color: Colors.blue),
                            onPressed: () {
                              // Navigate to profile picture update
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text("Channel Name",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                    labelText: "Flux Channel",
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a channel name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text("Description (optional)",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: descriptioncontroller,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: "A Superapp For Everyone",
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text("Channel Type",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Radio(
                      value: 0,
                      groupValue: radiovalue,
                      onChanged: _handleRadioValueChanged,
                    ),
                    Text("Private"),
                    SizedBox(width: 20),
                    Radio(
                      value: 1,
                      groupValue: radiovalue,
                      onChanged: _handleRadioValueChanged,
                    ),
                    Text("Public"),
                  ],
                ),
                SizedBox(height: 20),
                Text("Payment (Optional)",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: paymentcontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "e.g. 100",
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField(
                   decoration: InputDecoration(
                    labelText: "Category",
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if(value==null){
                      return "Select the category";
                    }else{
                      return null;
                    }
                  },
                  items:ChannelController.channelCategory.map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e))).toList() , onChanged: (selected){
                    selectedCategory=selected;
                  }),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      ChannelController().createChannel(ChannelModel(
                        category: selectedCategory!,
                          ownerId: FirebaseAuth.instance.currentUser!.uid,
                          profile: "",
                          members: [],
                          name: namecontroller.text,
                          description: descriptioncontroller.text,
                          type: typecontroller.text,
                          payment:paymentcontroller.text));
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => addmem()));
                    }
                  },
                  child: Text("Next"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
