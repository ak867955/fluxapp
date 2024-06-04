import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flux/application.dart';
import 'package:flux/collection/postworkmodel.dart';
import 'package:flux/collection/workmodel.dart';
import 'package:flux/data/worknow_controller.dart';
import 'package:flux/findtalent.dart';
import 'package:flux/profile.dart';
import 'package:flux/createprofile.dart';

class fwork extends StatefulWidget {
  String selectedCategory;
  fwork({super.key, required this.selectedCategory});

  @override
  State<fwork> createState() => _fworkState();
}

class _fworkState extends State<fwork> {
  // final List<String> categoryNames = [
  //   "Name",
  //   "Name",
  //   "Name",
  //   "Name",
  //   "Name",
  //   "Name",
  //   "Name",
  //   "Name",
  //   "Name",
  //   "Name",
  // ];

  // final List<String> imageAssets = [
  //   "asset/Ellipse 8.png",
  //   "asset/Ellipse 8.png",
  //   "asset/Ellipse 8.png",
  //   "asset/Ellipse 8.png",
  //   "asset/Ellipse 8.png",
  //   "asset/Ellipse 8.png",
  //   "asset/Ellipse 8.png",
  //   "asset/Ellipse 8.png",
  //   "asset/Ellipse 8.png",
  //   "asset/Ellipse 8.png",
  // ];

  // final List<String> description = [
  //   "Simple Description",
  //   "Simple Description",
  //   "Simple Description",
  //   "Simple Description",
  //   "Simple Description",
  //   "Simple Description",
  //   "Simple Description",
  //   "Simple Description",
  //   "Simple Description",
  //   "Simple Description",
  // ];

  // final List<String> dropdownOptions = [
  //   "All",
  //   "Logo Design",
  //   "Business Cards",
  //   "Illustration",
  //   "Flyer Design",
  //   "Social Media Design",
  //   "Web Design",
  // ];
  @override
  void initState() {
    selectFrom(widget.selectedCategory);
    // TODO: implement initState
    super.initState();
  }

  String? selectedOption;

  List<String> selectedCategoryList = [];

  selectFrom(selectedCategory) {
    switch (selectedCategory) {
      case 'Graphic & Design':
        {
          selectedCategoryList = WorkNowController.grephiscDesign;
          break;
        }
      case 'Digital Marketing':
        {
          selectedCategoryList = WorkNowController.digitalmarketing;
          break;
        }
      case 'Writing & Translation':
        {
          selectedCategoryList = WorkNowController.writingandtranslation;
          break;
        }
      case 'Video & Animation':
        {
          selectedCategoryList = WorkNowController.videoandanimation;
          break;
        }
      case 'Technology':
        {
          selectedCategoryList = WorkNowController.technology;
          break;
        }
      case 'Gaming':
        {
          selectedCategoryList = WorkNowController.gaming;
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButtonFormField<String>(
              value: selectedOption,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.blue),
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
                  // Update the card content based on the selected option if needed
                });
              },
              hint: Text("Select a Category"),
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            // Allow GridView to expand within available space
            child: StreamBuilder<QuerySnapshot>(
                stream: WorkNowController()
                    .getMyPostSelectedCategoryWork(widget.selectedCategory),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
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

                  if (snapshot.hasData) {
                    return listOfWork.isEmpty
                        ? Center(
                            child: Text("No Work"),
                          )
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Two columns
                              crossAxisSpacing: 10, // Spacing between columns
                              mainAxisSpacing: 10, // Spacing between rows
                            ),
                            itemCount: listOfWork
                                .length, // Replace with your actual data length
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  switch (index) {
                                    case 0:
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => profile()),
                                      );
                                      break;
                                    case 1:
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => profile()),
                                      );
                                      break;
                                    case 2:
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => profile()),
                                      );
                                      break;
                                    case 3:
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => profile()),
                                      );
                                      break;
                                    case 4:
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => profile()),
                                      );
                                      break;
                                    case 5:
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => profile()),
                                      );
                                      break;
                                    case 6:
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => profile()),
                                      );
                                      break;
                                    case 7:
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => profile()),
                                      );
                                      break;
                                    case 8:
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => profile()),
                                      );
                                      break;
                                    case 9:
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => profile()),
                                      );
                                      break;
                                  }
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
                                          margin: EdgeInsets.all(10),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            // child: Image.asset(
                                            //   listOfWork[index].,
                                            //   scale: 1,
                                            //   width: 100,
                                            // ),
                                          ),
                                        ),
                                        Text(
                                          listOfWork[index].title,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          listOfWork[index].description,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                  } else {
                    return SizedBox();
                  }
                }),
          )
        ],
      ),
    );
  }
}
