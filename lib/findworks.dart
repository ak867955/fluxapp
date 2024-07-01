import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flux/athorworker_profile.dart';
import 'package:flux/model/postworkmodel.dart';
import 'package:flux/data/worknow_controller.dart';

class FindWorks extends StatefulWidget {
  final String selectedCategory;
  const FindWorks({super.key, required this.selectedCategory});

  @override
  State<FindWorks> createState() => _FindWorksState();
}

class _FindWorksState extends State<FindWorks> {
  String? selectedOption;
  List<String> selectedCategoryList = [];

  @override
  void initState() {
    super.initState();
    selectFrom(widget.selectedCategory);
  }

  void selectFrom(String selectedCategory) {
    switch (selectedCategory) {
      case 'Graphic & Design':
        selectedCategoryList = WorkNowController.grephiscDesign;
        break;
      case 'Digital Marketing':
        selectedCategoryList = WorkNowController.digitalmarketing;
        break;
      case 'Writing & Translation':
        selectedCategoryList = WorkNowController.writingandtranslation;
        break;
      case 'Video & Animation':
        selectedCategoryList = WorkNowController.videoandanimation;
        break;
      case 'Technology':
        selectedCategoryList = WorkNowController.technology;
        break;
      case 'Gaming':
        selectedCategoryList = WorkNowController.gaming;
        break;
      default:
        selectedCategoryList = [];
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButtonFormField<String>(
              value: selectedOption,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
              items: selectedCategoryList.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedOption = newValue;
                });
              },
              hint: const Text("Select a Category"),
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: WorkNowController()
                  .getAllPostExceptMinSelectedCategoryWork(
                      widget.selectedCategory),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData) {
                  return const Center(child: Text("No Work"));
                }

                List<Postworkmodel> listOfWork = snapshot.data!.docs
                    .map((e) => Postworkmodel.fromData(
                        e.data() as Map<String, dynamic>))
                    .where((element) =>
                        selectedOption == null ||
                        element.subCategory == selectedOption)
                    .toList();

                return listOfWork.isEmpty
                    ? const Center(child: Text("No Work"))
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: listOfWork.length,
                        itemBuilder: (context, index) {
                          final work = listOfWork[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AthoWorkerProfile(
                                        workerProfileId: work.uid!)),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundImage: work.profileImage !=
                                                  null
                                              ? (work.profileImage!
                                                      .startsWith('http')
                                                  ? NetworkImage(
                                                      work.profileImage!)
                                                  : FileImage(File(
                                                          work.profileImage!))
                                                      as ImageProvider)
                                              : const AssetImage(
                                                  "assets/profile_placeholder.png"),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      work.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(work.description),
                                    Text(work.budget.toString()),
                                    Text(work.level),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
