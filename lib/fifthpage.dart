import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flux/collection/myprofilemodel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flux/drawer.dart';
import 'package:flux/flux.dart';
import 'package:flux/chat.dart';
import 'package:flux/collection/collection.dart';
import 'package:flux/collection/profilemodel.dart';

class page5 extends StatefulWidget {
  const page5({super.key});

  @override
  State<page5> createState() => _page5State();
}

class _page5State extends State<page5> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController secondnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController aboutmecontroller = TextEditingController();
  TextEditingController skillcontroller = TextEditingController();
  TextEditingController qualificationcontroller = TextEditingController();
  TextEditingController experiencecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  String? _selectedGender;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  UploadTask? _uploadTask;
  String? url;

  String? _validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Please enter an email';
    }
    RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  Future<void> _getImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
        _uploadImage();
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_profileImage == null) return;

    final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final reference = _storage.ref().child('profileImages/$fileName');

    setState(() {
      _uploadTask = reference.putFile(
          _profileImage!, SettableMetadata(contentType: 'image/jpeg'));
    });

    await _uploadTask!.then((p0) async {
      url = await p0.ref.getDownloadURL().then((value) => url = value);
    });

    log('Image uploaded successfully: $url');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    _profileImage != null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundImage: FileImage(_profileImage!),
                          )
                        : CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage("assets/profile_placeholder.png"),
                          ),
                    Positioned(
                      bottom: 5.0,
                      right: 5.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        radius: 15,
                        child: IconButton(
                          icon: const Icon(Icons.edit, size: 15),
                          color: Colors.blue,
                          onPressed: _getImage,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  "Profile Info",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: firstnameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    labelText: "First Name",
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: secondnameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    labelText: "Second Name",
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: _validateEmail,
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: aboutmecontroller,
                  maxLength: 20,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    labelText: "About Me",
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: skillcontroller,
                  maxLength: 10,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    labelText: "Skill",
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: qualificationcontroller,
                  maxLength: 20,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    labelText: "Qualification",
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: experiencecontroller,
                  maxLength: 20,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    labelText: "Experience",
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildAgeField(),
                    _buildGenderDropdown(),
                  ],
                ),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: Text(
                    "By Signing Up, You Agree to Our Terms of Services",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Controller().addprofile(Myprofilemodel(
              firstname: firstnameController.text,
              secondname: secondnameController.text,
              aboutme: aboutmecontroller.text,
              skill: skillcontroller.text,
              qualification: qualificationcontroller.text,
              experience: experiencecontroller.text,
              age: int.parse(agecontroller.text),
              gender: _selectedGender.toString(),
              email: emailController.text,
              url: url!));

          // Navigate to Chat page
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => bottomnavipage(initialIndex: 0)),
            (Route<dynamic> route) => false,
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildAgeField() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: agecontroller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Age",
            hintText: "Eg : 23",
          ),
        ),
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Gender",
          ),
          value: _selectedGender,
          items: ["Male", "Female", "Others"]
              .map((gender) => DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  ))
              .toList(),
          onChanged: (newValue) {
            setState(() {
              _selectedGender = newValue;
            });
          },
        ),
      ),
    );
  }
}
