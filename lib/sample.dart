// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flux/model/postworkmodel.dart';
// import 'package:flux/data/worknow_controller.dart';

// class MyWorks extends StatefulWidget {
//   final String selectedCategory;
//   const MyWorks({super.key, required this.selectedCategory});

//   @override
//   State<MyWorks> createState() => _MyWorksState();
// }

// class _MyWorksState extends State<MyWorks> {
//   String? selectedOption;
//   List<String> selectedCategoryList = [];

//   @override
//   void initState() {
//     super.initState();
//     selectFrom(widget.selectedCategory);
//   }

//   void selectFrom(String selectedCategory) {
//     switch (selectedCategory) {
//       case 'Graphic & Design':
//         selectedCategoryList = WorkNowController.grephiscDesign;
//         break;
//       case 'Digital Marketing':
//         selectedCategoryList = WorkNowController.digitalmarketing;
//         break;
//       case 'Writing & Translation':
//         selectedCategoryList = WorkNowController.writingandtranslation;
//         break;
//       case 'Video & Animation':
//         selectedCategoryList = WorkNowController.videoandanimation;
//         break;
//       case 'Technology':
//         selectedCategoryList = WorkNowController.technology;
//         break;
//       case 'Gaming':
//         selectedCategoryList = WorkNowController.gaming;
//         break;
//       default:
//         selectedCategoryList = [];
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Works", style: TextStyle(color: Colors.white)),
//         backgroundColor: const Color.fromRGBO(8, 38, 76, 1),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             const SizedBox(height: 10),
//             DropdownButtonFormField<String>(
//               value: selectedOption,
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.white,
//                 contentPadding:
//                     const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                   borderSide: const BorderSide(color: Colors.grey),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                   borderSide: const BorderSide(color: Colors.blue),
//                 ),
//               ),
//               items: selectedCategoryList.map((String option) {
//                 return DropdownMenuItem<String>(
//                   value: option,
//                   child: Text(option),
//                 );
//               }).toList(),
//               onChanged: (String? newValue) {
//                 setState(() {
//                   selectedOption = newValue;
//                 });
//               },
//               hint: const Text("Select a Category"),
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: WorkNowController()
//                     .getMyPostSelectedCategoryWork(widget.selectedCategory),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                   if (snapshot.hasError) {
//                     return const Center(
//                       child: Text("Error loading works"),
//                     );
//                   }
//                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                     return const Center(
//                       child: Text("No Work"),
//                     );
//                   }

//                   List<Postworkmodel> listOfWork = [];
//                   if (selectedOption != null) {
//                     final list = snapshot.data!.docs
//                         .map((e) => Postworkmodel.fromData(
//                             e.data() as Map<String, dynamic>))
//                         .toList();

//                     listOfWork = list
//                         .where((element) => element.subCategory == selectedOption)
//                         .toList();
//                   } else {
//                     listOfWork = snapshot.data!.docs
//                         .map((e) => Postworkmodel.fromData(
//                             e.data() as Map<String, dynamic>))
//                         .toList();
//                   }

//                   return GridView.builder(
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                     ),
//                     itemCount: listOfWork.length,
//                     itemBuilder: (context, index) {
//                       final work = listOfWork[index];
//                       return SizedBox(
//                         child: Stack(
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 // Implement work item tap action
//                               },
//                               child: Card(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20.0),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Column(
//                                     children: [
//                                       Container(
//                                         margin: const EdgeInsets.all(10),
//                                         child: ClipRRect(
//                                           borderRadius: BorderRadius.circular(10),
//                                           child: CircleAvatar(
//                                             radius: 50,
//                                             backgroundImage: work.profileImage != null
//                                                 ? (work.profileImage!.startsWith('http')
//                                                     ? NetworkImage(work.profileImage!)
//                                                     : FileImage(File(work.profileImage!))
//                                                         as ImageProvider)
//                                                 : const AssetImage(
//                                                     "assets/profile_placeholder.png",
//                                                   ),
//                                           ),
//                                         ),
//                                       ),
//                                       Text(
//                                         work.title,
//                                         style: const TextStyle(
//                                             fontWeight: FontWeight.bold),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                       Text(
//                                         work.description,
//                                         textAlign: TextAlign.center,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               right: 8,
//                               top: 8,
//                               child: Container(
//                                 alignment: Alignment.center,
//                                 width: 45,
//                                 height: 45,
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.shade300,
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: IconButton(
//                                   onPressed: () {
//                                     FirebaseFirestore.instance
//                                         .collection('Post Work Info')
//                                         .doc(work.workId)
//                                         .delete()
//                                         .then((value) {
//                                       ScaffoldMessenger.of(context).showSnackBar(
//                                         const SnackBar(
//                                           content: Text('DELETE SUCCESSFUL'),
//                                         ),
//                                       );
//                                     });
//                                   },
//                                   icon: const Icon(
//                                     Icons.delete,
//                                     color: Colors.black54,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
