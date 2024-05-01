import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class address extends StatelessWidget {
  const address({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verification"),
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
          Text(
            "Get verified to access all features",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Complete your address verification to unlock additional features and functionalities.",
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Account status",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text("Unverified"),
          SizedBox(
            height: 10,
          ),
          Text(
            "Enter your address information",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Full Name",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Street Address",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Flexible(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "City",
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "State/Province",
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Flexible(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Postal Code",
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Country",
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Start Verification"),
          ),
        ],
      ),
    );
  }
}
