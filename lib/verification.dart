import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flux/address.dart';
import 'package:flux/bankverification.dart';
import 'package:flux/panverification.dart';

class verification extends StatelessWidget {
  const verification({super.key});

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
            "Get verified to access all features Complete your verification to access all of our platform's features."
            "This is required for monetization and payouts.",
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
            "What we need from you",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => panveri()));
                },
                child: Text("Pan Card"),
              ),
              Icon(Icons.arrow_forward_ios_outlined)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => address()));
                },
                child: Text("Adress Proof"),
              ),
              Icon(Icons.arrow_forward_ios_outlined)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => bank()));
                },
                child: Text("Bank Account Details"),
              ),
              Icon(Icons.arrow_forward_ios_outlined)
            ],
          ),
          ElevatedButton(onPressed: () {}, child: Text("Start Verification"))
        ],
      ),
    );
  }
}
