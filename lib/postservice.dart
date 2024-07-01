import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flux/flux.dart';
// import 'package:flux/worknow.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flux/model/collection.dart';
import 'package:flux/model/servicemodel.dart';

class PostService extends StatefulWidget {
  const PostService({Key? key}) : super(key: key);

  @override
  State<PostService> createState() => _PostServiceState();
}

File? selectedimage;

class _PostServiceState extends State<PostService> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String _selectedDuration = '1 Hour';
  String _selectedCategory = 'Plumbing';
  // String? workid;

  String url = '';

  final List<String> _durations = [
    '1 Hour',
    '2 Hours',
    '4 Hours',
    'Less than 24 Hours',
  ];

  final List<String> _categories = [
    "Plumbing",
    "Electrician",
    "Taxi",
    "Courier",
    "Food Delivery",
    "Cleaning",
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _pickImage() async {
      final pickedimage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedimage == null) return;

      setState(() {
        selectedimage = File(pickedimage.path);
      });
    }

    final ValueNotifier<bool> isloading = ValueNotifier(false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Post Service",
          style: TextStyle(color: Colors.white),
        ),
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
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                _buildSectionTitle("Title"),
                _buildTextField(
                  "Enter Title",
                  maxLength: 50,
                  controller: _titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                _buildSectionTitle("Description"),
                _buildTextField(
                  "Enter Description",
                  maxLength: 200,
                  controller: _descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPriceField(
                      label: "Price",
                      hintText: "Enter Your Price",
                      controller: _priceController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a price';
                        }
                        return null;
                      },
                    ),
                    SizedBox(width: 5),
                    _buildDropdownField(
                      label: "Duration",
                      items: _durations,
                      value: _selectedDuration,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedDuration = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildDropdownField(
                  label: "Category",
                  items: _categories,
                  value: _selectedCategory,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          _pickImage().then((value) async {
                            isloading.value = true;

                            SettableMetadata metadata =
                                SettableMetadata(contentType: 'image/jpeg');
                            final curenttime = TimeOfDay.now();

                            UploadTask uploadTask = FirebaseStorage.instance
                                .ref()
                                .child('Postservice/post$curenttime')
                                .putFile(selectedimage!, metadata);

                            TaskSnapshot taskSnapshot = await uploadTask;

                            setState(() async {
                              url = await taskSnapshot.ref.getDownloadURL();
                            });
                            isloading.value = false;
                          });
                        },
                        icon: Icon(Icons.file_copy, color: Colors.white),
                        label: Text("Add Files"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(8, 38, 76, 1),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          textStyle: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Center(
                    child: ValueListenableBuilder<bool>(
                  valueListenable: isloading,
                  builder: (context, loading, child) {
                    return ElevatedButton(
                      onPressed: loading
                          ? null
                          : () async {
                              if (url != null) {
                                if (_formKey.currentState!.validate()) {
                                  await postService().then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Service successfully posted')));
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              bottomnavipage(initialIndex: 3)),
                                    );
                                  });
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('image uploading wait')));
                              }
                            },
                      child:
                          loading ? Text('Please wait ') : Text("Post Service"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                    );
                  },
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future postupload(image) async {}

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Color.fromRGBO(8, 38, 76, 1),
      ),
    );
  }

  Widget _buildTextField(
    String hintText, {
    int? maxLength,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        validator: validator,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: hintText,
          counterText: '',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildPriceField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .35,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: validator,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
          hintText: hintText,
          counterText: '',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required List<String> items,
    required String value,
    required void Function(String?) onChanged,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
          hintText: label,
        ),
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  int _getDurationInHours(String duration) {
    switch (duration) {
      case '1 Hour':
        return 1;
      case '2 Hours':
        return 2;
      case '4 Hours':
        return 4;
      case 'Less than 24 Hours':
        return 24;
      default:
        return 0;
    }
  }

  Future<void> postService() async {
    final serviceModel = Servicemodel(
      title: _titleController.text,
      description: _descriptionController.text,
      price: double.parse(_priceController.text),
      duration: _getDurationInHours(_selectedDuration),
      category: _selectedCategory,
      timestamp: Timestamp.now(),
      uid: FirebaseAuth.instance.currentUser!.uid,
      imageUrl: url,
    );

    await Controller().postservice(serviceModel);

    _formKey.currentState!.reset();

  }
}
