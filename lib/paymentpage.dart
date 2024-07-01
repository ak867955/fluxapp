import 'package:flutter/material.dart';
import 'package:flux/chat.dart';
import 'package:flux/model/bankmodel.dart';
import 'package:flux/model/collection.dart';
import 'package:flux/flux.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final accnameController = TextEditingController();
  final upiidController = TextEditingController();

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
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  "What we need from you",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  "Account Holder's Name",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: accnameController,
                  maxLength: 15,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter Account Holder's Name",
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter account holder\'s name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text(
                  "UPI ID",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: upiidController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter UPI ID",
                    prefixIcon: Icon(Icons.account_balance),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your UPI ID';
                    }
                    if (!RegExp(r'^[\w.-]+@[\w.-]+$').hasMatch(value)) {
                      return 'Enter a valid UPI ID';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await Controller().addbank(Bankmodel(
                            accountname: accnameController.text,
                            upiid: upiidController.text,
                          ));
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Success"),
                                content: Text("Successfully Saved"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => bottomnavipage(initialIndex: 0),
                                        ),
                                      );
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Error"),
                                content: Text("Failed to save data: $e"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                    child: Text("Start Verification"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(8, 38, 76, 1),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
