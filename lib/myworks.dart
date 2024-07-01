import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flux/model/postworkmodel.dart';
import 'package:flux/data/worknow_controller.dart';

class MyWorks extends StatefulWidget {
  final String selectedCategory;
  const MyWorks({super.key, required this.selectedCategory});

  @override
  State<MyWorks> createState() => _MyWorksState();
}

class _MyWorksState extends State<MyWorks> {
  String? selectedOption;
  List<String> selectedCategoryList = [];

  @override
  void initState() {
    selectFrom(widget.selectedCategory);
    super.initState();
  }

  selectFrom(selectedCategory) {
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
                  .getMyPostSelectedCategoryWork(widget.selectedCategory),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  List<Postworkmodel> listOfWork = [];
                  if (selectedOption != null) {
                    final list = snapshot.data!.docs
                        .map((e) => Postworkmodel.fromData(
                            e.data() as Map<String, dynamic>))
                        .toList();

                    listOfWork = list
                        .where(
                            (element) => element.subCategory == selectedOption)
                        .toList();
                  } else {
                    listOfWork = snapshot.data!.docs
                        .map((e) => Postworkmodel.fromData(
                            e.data() as Map<String, dynamic>))
                        .toList();
                  }

                  return listOfWork.isEmpty
                      ? const Center(
                          child: Text("No Work"),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            // crossAxisSpacing: 10,
                            // mainAxisSpacing: 10,
                          ),
                          itemCount: listOfWork.length,
                          itemBuilder: (context, index) {
                            final work = listOfWork[index];
                            return WorkCard(work: work);
                          },
                        );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WorkCard extends StatelessWidget {
  final Postworkmodel work;

  const WorkCard({Key? key, required this.work}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: work.profileImage != null
                    ? (work.profileImage!.startsWith('http')
                        ? NetworkImage(work.profileImage!)
                        : FileImage(File(work.profileImage!)) as ImageProvider)
                    : const AssetImage("assets/profile_placeholder.png"),
              ),
              title: Text(
                work.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              work.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              "Budget: \$${work.budget}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              "Skills: ${work.skills}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              "Level: ${work.level}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              "Deadline: ${work.deadline} days",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Category: \$${work.category}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "SubCategory: \$${work.subCategory}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('Post Work Info')
                        .doc(work.workId)
                        .delete()
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('DELETE SUCCESSFUL'),
                        ),
                      );
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text("Delete"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
