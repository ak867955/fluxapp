import 'package:flutter/material.dart';
import 'package:flux/collection/collection.dart';
import 'package:flux/collection/postworkmodel.dart';
import 'package:flux/data/worknow_controller.dart';
import 'package:flux/flux.dart'; // Import the chat page

class pwork extends StatefulWidget {
  const pwork({super.key});

  @override
  _pworkState createState() => _pworkState();
}

class _pworkState extends State<pwork> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final budgetController = TextEditingController();
  final skillController = TextEditingController();

  String? selectedCategory;
  String? selectedLevel;
  String? selectedDeadline;
  String? selectedSubCategory;

  final List<String> profileSections = [
    'Title',
    'Description',
    'Budget',
    'Deadline',
    'Skills',
    'Choose Category',
    'Level',
    'Sub Category'
  ];

  final List<String> categories = [
    'Graphic & Design',
    'Digital Marketing',
    'Writing & Translation',
    'Video & Animation',
    'Technology',
    'Gaming',
  ];

  final List<String> levels = [
    'Beginner',
    'Intermediate',
    'Master',
  ];

  final List<String> deadlines = [
    '1 day',
    '3 days',
    '7 days',
    '10 days',
  ];

  List<String> selectedSubCategoryList = [];

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    budgetController.dispose();
    skillController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Post Work",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
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
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: profileSections.length,
                  itemBuilder: (context, index) {
                    final section = profileSections[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            section,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          if (section == 'Choose Category')
                            DropdownButtonFormField<String>(
                              validator: (value) {
                                if (value == null) {
                                  return "Feild is required";
                                } else {
                                  return null;
                                }
                              },
                              value: selectedCategory,
                              items: categories.map((String category) {
                                return DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(category),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  // 'Graphic & Design',
                                  // 'Digital Marketing',
                                  // 'Writing & Translation',
                                  // 'Video & Animation',
                                  // 'Technology',
                                  // 'Gaming',
                                  selectedCategory = newValue;
                                  switch (selectedCategory) {
                                    case 'Graphic & Design':
                                      {
                                        selectedSubCategoryList =
                                            WorkNowController.grephiscDesign;
                                        break;
                                      }
                                    case 'Digital Marketing':
                                      {
                                        selectedSubCategoryList =
                                            WorkNowController.digitalmarketing;
                                        break;
                                      }
                                    case 'Writing & Translation':
                                      {
                                        selectedSubCategoryList =
                                            WorkNowController
                                                .writingandtranslation;
                                        break;
                                      }
                                    case 'Video & Animation':
                                      {
                                        selectedSubCategoryList =
                                            WorkNowController.videoandanimation;
                                        break;
                                      }
                                    case 'Technology':
                                      {
                                        selectedSubCategoryList =
                                            WorkNowController.technology;
                                        break;
                                      }
                                    case 'Gaming':
                                      {
                                        selectedSubCategoryList =
                                            WorkNowController.gaming;
                                        break;
                                      }
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.grey[100],
                              ),
                            )
                          else if (section == 'Level') 
                            DropdownButtonFormField<String>(
                              validator: (value) {
                                if (value == null) {
                                  return "Feild is required";
                                } else {
                                  return null;
                                }
                              },
                              value: selectedLevel,
                              items: levels.map((String level) {
                                return DropdownMenuItem<String>(
                                  value: level,
                                  child: Text(level),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedLevel = newValue;
                                });
                              },
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.grey[100],
                              ),
                            )
                          else if (section == 'Deadline')
                            DropdownButtonFormField<String>(
                              validator: (value) {
                                if (value == null) {
                                  return "Feild is required";
                                } else {
                                  return null;
                                }
                              },
                              value: selectedDeadline,
                              items: deadlines.map((String deadline) {
                                return DropdownMenuItem<String>(
                                  value: deadline,
                                  child: Text(deadline),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedDeadline = newValue;
                                });
                              },
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.grey[100],
                              ),
                            )
                          else if (section == 'Sub Category')
                            DropdownButtonFormField<String>(
                              validator: (value) {
                                if (value == null) {
                                  return "Feild is required";
                                } else {
                                  return null;
                                }
                              },
                              value: selectedSubCategory,
                              items: selectedSubCategoryList.map((String sub) {
                                return DropdownMenuItem<String>(
                                  value: sub,
                                  child: Text(sub),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedSubCategory = newValue;
                                });
                              },
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.grey[100],
                              ),
                            )
                          else
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Feild is required";
                                } else {
                                  return null;
                                }
                              },
                              controller: _getController(section),
                              maxLength: section == 'Description' ? 200 : null,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.grey[100],
                                counterText: '',
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await Controller().postwork(Postworkmodel(
                            subCategory: selectedSubCategory!,
                            title: titleController.text,
                            description: descriptionController.text,
                            budget: double.parse(budgetController.text),
                            deadline: _parseDeadline(selectedDeadline),
                            skills: skillController.text,
                            category: selectedCategory ?? '',
                            level: selectedLevel ?? ''));
                        // Show Snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Work Posted Successfully'),
                          ),
                        );
                        // Navigate to Chat Page
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const bottomnavipage(initialIndex: 0)),
                        );
                      }
                    },
                    child: const Text("Post Work"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      textStyle: const TextStyle(fontSize: 16),
                      backgroundColor: const Color.fromRGBO(8, 38, 76, 1),
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

  TextEditingController? _getController(String section) {
    switch (section) {
      case 'Title':
        return titleController;
      case 'Description':
        return descriptionController;
      case 'Budget':
        return budgetController;
      case 'Skills':
        return skillController;
      default:
        return null;
    }
  }

  int _parseDeadline(String? deadline) {
    switch (deadline) {
      case '1 day':
        return 1;
      case '3 days':
        return 3;
      case '7 days':
        return 7;
      case '10 days':
        return 10;
      default:
        return 0;
    }
  }
}
