import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flux/flux.dart';
import 'package:flux/model/collection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flux/model/panmodel.dart';
// import 'package:flux/controller.dart';  // Assuming you have a Controller class for adding the PAN details
// import 'package:flux/bottomnavipage.dart';  // Assuming you have a bottomnavipage class for navigation

class PanVerification extends StatefulWidget {
  const PanVerification({super.key});

  @override
  State<PanVerification> createState() => _PanVerificationState();
}

class _PanVerificationState extends State<PanVerification> {
  final numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String imageUrl = '';

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }

  String? validatePanCardNumber(String value) {
    String pattern = r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid PAN card number';
    } else {
      return null;
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageUrl = image
            .path; // For now, we use the local path. You may want to upload it to a server and get a URL.
      });
    }
  }

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
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Get verified to access all features",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  "Complete your verification to access all of our platform's features. "
                  "This is required for monetization and payouts.",
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
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  "What we need from you",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  "Pan Card Number",
                  style: TextStyle(fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: numberController,
                    maxLength: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter Your Pan Card Number",
                      prefixIcon: Icon(Icons.credit_card),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a PAN card number';
                      }
                      return validatePanCardNumber(value);
                    },
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: pickImage,
                    child: Text("Add Pan Card Image"),
                  ),
                ),
                if (imageUrl.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Image.file(
                        File(imageUrl),
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        try {
                          await Controller().addpan(
                            Panmodel(
                                pannumber: numberController.text,
                                imageurl: imageUrl),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Verification Started")),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    bottomnavipage(initialIndex: 0)),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error: ${e.toString()}")),
                          );
                        }
                      }
                    },
                    child: Text("Start Verification"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(8, 38, 76, 1),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PanVerification(),
  ));
}
