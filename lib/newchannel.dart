import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flux/flux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flux/addmemebers.dart';
import 'package:flux/model/collection.dart';
import 'package:flux/model/newchannelmodel.dart';
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
  final paymentcontroller = TextEditingController();
  String? selectedCategory;
  int radiovalue = 0;
  File? _profileImage;
  final ValueNotifier<bool> isUploading = ValueNotifier(false);
  final ValueNotifier<bool> isSubmitting = ValueNotifier(false);

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<String> uploadImage(File image) async {
    try {
      isUploading.value = true;
      String fileName =
          'channel_profiles/${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference storageReference =
          FirebaseStorage.instance.ref().child(fileName);

      UploadTask uploadTask = storageReference.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      isUploading.value = false;
      return downloadURL;
    } catch (e) {
      print("Error uploading image: $e");
      isUploading.value = false;
      return "";
    }
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
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : AssetImage("assets/default_profile.png")
                                as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          radius: 20,
                          child: IconButton(
                            icon: Icon(Icons.edit, size: 20, color: Colors.blue),
                            onPressed: _pickImage,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                _buildSectionTitle("Channel Name"),
                SizedBox(height: 15),
                _buildTextField(
                  "Enter Channel Name",
                  controller: namecontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a channel name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                _buildSectionTitle("Description (optional)"),
                SizedBox(height: 15),
                _buildTextField(
                  "Enter Description",
                  controller: descriptioncontroller,
                  maxLines: 3,
                ),
                SizedBox(height: 20),
                _buildSectionTitle("Payment (Optional)"),
                SizedBox(height: 15),
                _buildTextField(
                  "Enter Payment",
                  controller: paymentcontroller,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                _buildSectionTitle("Category"),
                SizedBox(height: 15),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "Select the category";
                    } else {
                      return null;
                    }
                  },
                  items: ChannelController.channelCategory
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (selected) {
                    selectedCategory = selected;
                  },
                ),
                SizedBox(height: 20),
                // Center(
                //   child: ValueListenableBuilder<bool>(
                //     valueListenable: isUploading,
                //     // builder: (context, uploading, child) {
                //     //   // return ElevatedButton.icon(
                //     //   //   onPressed: uploading ? null : _pickImage,
                //     //   //   icon: uploading
                //     //   //       ? CircularProgressIndicator(color: Colors.white)
                //     //   //       : Icon(Icons.file_copy, color: Colors.white),
                //     //   //   label: uploading
                //     //   //       ? Text("Uploading...")
                //     //   //       //  Text("Add Profile Image"),
                //     //   //   style: ElevatedButton.styleFrom(
                //     //   //     backgroundColor: Color.fromRGBO(8, 38, 76, 1),
                //     //   //     padding: EdgeInsets.symmetric(
                //     //   //         horizontal: 20, vertical: 12),
                //     //   //     textStyle: TextStyle(fontSize: 16),
                //     //   //   ),
                //     //   // );
                //     // },
                //   ),
                // ),
                SizedBox(height: 20),
                Center(
                  child: ValueListenableBuilder<bool>(
                    valueListenable: isSubmitting,
                    builder: (context, submitting, child) {
                      return ElevatedButton(
                        onPressed: submitting
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  isSubmitting.value = true;
                                  String profileUrl = _profileImage != null
                                      ? await uploadImage(_profileImage!)
                                      : "";
                                  ChannelController().createChannel(ChannelModel(
                                    category: selectedCategory!,
                                    ownerId: FirebaseAuth.instance.currentUser!.uid,
                                    profile: profileUrl,
                                    members: [],
                                    name: namecontroller.text,
                                    description: descriptioncontroller.text,
                                    payment: paymentcontroller.text,
                                  ));

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Successfully Channel Created"),
                                    ),
                                  );
                                  isSubmitting.value = false;

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          bottomnavipage(initialIndex: 1),
                                    ),
                                  );
                                }
                              },
                        child: submitting
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text("Create Channel"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(8, 38, 76, 1),
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Color.fromRGBO(8, 38, 76, 1),
      ),
    );
  }

  Widget _buildTextField(
    String labelText, {
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }
}
