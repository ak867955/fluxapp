import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flux/model/collection.dart';
import 'package:flux/model/workmodel.dart';
import 'package:flux/flux.dart';

class WorkExperience extends StatefulWidget {
  const WorkExperience({super.key});

  @override
  State<WorkExperience> createState() => _WorkExperienceState();
} 

class _WorkExperienceState extends State<WorkExperience> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController(); 
  final companyController = TextEditingController();
  final jobDescriptionController = TextEditingController();
  final referenceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Verify Your Work Experience",
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter your job information",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Job Name",
                    prefixIcon: Icon(Icons.work),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your job name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: companyController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Company Name",
                    prefixIcon: Icon(Icons.business),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your company name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: jobDescriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Job Description",
                    prefixIcon: Icon(Icons.description),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your job description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: referenceController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "References",
                    prefixIcon: Icon(Icons.contacts),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your references';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.file_copy, color: Colors.white),
                    label: Text("Add Files"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(8, 38, 76, 1),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => bottomnavipage(initialIndex: 0)));
                      },
                      child: Text("Continue Later"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        textStyle: TextStyle(fontSize: 16),
                      ),
                    ),
                    ElevatedButton( 
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await Controller().addwork(Workmodel(
                              jobname: nameController.text,
                              companyname: companyController.text,
                              jobdescription: jobDescriptionController.text,
                              reference: referenceController.text,
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
                                              builder: (context) => bottomnavipage(initialIndex: 0)),
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
                      child: Text("Done"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        textStyle: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
