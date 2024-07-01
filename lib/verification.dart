import 'package:flutter/material.dart';
import 'package:flux/address.dart';
import 'package:flux/paymentpage.dart';
import 'package:flux/panverification.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verification", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1), // Adjusted color to match your theme
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
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
            SizedBox(height: 16),
            Text(
              "Complete your verification to access all of our platform's features. This is required for monetization and payouts.",
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 24),
            Text(
              "Account Status",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 12),
            Text(
              "Unverified",
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 24),
            Text(
              "What We Need from You",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 24),
            _buildVerificationItem(
              context,
              "Pan Card",
              Icons.arrow_forward_ios_outlined,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PanVerification()),
                );
              },
            ),
            SizedBox(height: 16),
            _buildVerificationItem(
              context,
              "Address Proof",
              Icons.arrow_forward_ios_outlined,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddressVerification()),
                );
              },
            ),
            SizedBox(height: 16),
            _buildVerificationItem(
              context,
              "Payments",
              Icons.arrow_forward_ios_outlined,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationItem(
      BuildContext context, String title, IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 16)),
            Icon(icon, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
