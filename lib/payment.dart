import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flux/paymentpage.dart';
import 'package:flux/worknow/screen_payment.dart';

class payment extends StatefulWidget {
  String anotherUserId;
  payment({super.key, required this.anotherUserId});

  @override
  State<payment> createState() => _paymentState();
}

class _paymentState extends State<payment> {
  final amount = TextEditingController();
  final note = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pay", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(8, 38, 76, 1), 
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Amount",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                setState(() {
                  
                });
              },
              controller: amount,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Enter amount",
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            const Text(
              "Add a note",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: note,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Add a note",
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 20),
            const Text(
              "Choose Payment Method",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
              amount.text.isNotEmpty?      FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("Bank Details")
                    .doc(widget.anotherUserId)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data!.exists) {
                    return Expanded(
                      child: PaymentScreen(
                          amount: double.parse(amount.text),
                          accountHolerName:
                              snapshot.data!.data()!["Account Holder Name"],
                          recieverUPIID: snapshot.data!.data()!["UPI iD"]),
                    );
                  } else {
                    // return Expanded(
                    //   child: PaymentScreen(
                    //       amount: double.parse(amount.text),
                    //       accountHolerName:
                    //          "szx",
                    //       recieverUPIID: "1234567890@paytm"),   //lllllllllllllllllllllllllllllllllllllllllllllll
                    // );
        
                  return Center(child: Text("Bank Details Not Found"),);
                  }
                }):SizedBox(),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                  backgroundColor: const Color.fromRGBO(8, 38, 76, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Pay now',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
