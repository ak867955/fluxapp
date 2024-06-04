import 'package:flutter/material.dart';
import 'package:flux/address.dart';
import 'package:flux/bankverification.dart';
import 'package:flux/panverification.dart';

class verification extends StatelessWidget {
  const verification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verification", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: Colors.white,),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Get verified to access all features",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              "Complete your verification to access all of our platform's features. This is required for monetization and payouts.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              "Account status",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Unverified",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              "What we need from you",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            _buildVerificationItem(context, "Pan Card", Icons.arrow_forward_ios_outlined, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => panveri()));
            }),
            SizedBox(height: 10),
            _buildVerificationItem(context, "Address Proof", Icons.arrow_forward_ios_outlined, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => address()));
            }),
            SizedBox(height: 10),
            _buildVerificationItem(context, "Bank Account Details", Icons.arrow_forward_ios_outlined, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => bank()));
            }),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {}, 
                child: Text("Start Verification", style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationItem(BuildContext context, String title, IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16)),
          Icon(icon, color: Colors.grey),
        ],
      ),
    );
  }
}
