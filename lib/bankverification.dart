import 'package:flutter/material.dart';
import 'package:flux/chat.dart';
import 'package:flux/collection/bankmodel.dart';
import 'package:flux/collection/collection.dart';

class bank extends StatefulWidget {
  const bank({super.key});

  @override
  State<bank> createState() => _bankState();
}

class _bankState extends State<bank> {
  final _formKey = GlobalKey<FormState>();
  final accnumController = TextEditingController();
  final accnameController = TextEditingController();
  final ifscController = TextEditingController();

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
                  maxLength: 50,
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
                  "Account Number",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: accnumController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter your account number",
                    prefixIcon: Icon(Icons.account_balance),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your account number';
                    }
                    if (!RegExp(r'^\d{9,18}$').hasMatch(value)) {
                      return 'Enter a valid account number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text(
                  "IFSC Code",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: ifscController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter your IFSC Code",
                    prefixIcon: Icon(Icons.code),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your IFSC code';
                    }
                    if (!RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(value)) {
                      return 'Enter a valid IFSC code';
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
                            accnumber: int.parse(accnumController.text),
                            ifsccode: int.parse(ifscController.text),
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
                                          builder: (context) => Chat(),
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
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

