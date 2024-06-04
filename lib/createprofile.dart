// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// // import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flux/chat.dart'; 
// import 'package:flux/collection/collection.dart';
// import 'package:flux/collection/profilemodel.dart';

// class createprofile extends StatefulWidget {
//   const createprofile({super.key});

//   @override
//   State<createprofile> createState() => _createprofileState();
// }

// class _createprofileState extends State<createprofile> {
//   final namecontroller = TextEditingController();
//   final aboutmecontroller = TextEditingController();
//   final skillcontroller = TextEditingController();
//   final qualificationcontroller = TextEditingController();
//   final experiencecontroller = TextEditingController();
//   final agecontroller = TextEditingController();
//   // final gendercontroller = TextEditingController();
//   String? _selectedGender; // This will store the selected gender

//   @override 
//   Widget build(BuildContext context) {
//     return Scaffold( 
//       appBar: AppBar(
//         title: Text("Profile", style: TextStyle(color: Colors.white)),
//         backgroundColor: Color.fromRGBO(8, 38, 76, 1),
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(Icons.arrow_back, color: Colors.white)),
//         centerTitle: true,
//         actions: [
//           TextButton(  
//               onPressed: () async {
//                 await Controller().addProfile(Profilemodel(
//                     name: namecontroller.text,
//                     aboutme: aboutmecontroller.text,
//                     skill: skillcontroller.text,
//                     qualification: qualificationcontroller.text,
//                     experience: experiencecontroller.text,
//                     age: int.parse(agecontroller.text),
//                     gender: _selectedGender.toString()));
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog( 
//                       title: Text("Success"),
//                       content: Text("Successfully saved"),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => chat(),
//                               ),
//                             );
//                           },
//                           child: Text("OK"),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//               child: Text("Save", style: TextStyle(color: Colors.white)))
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "Create Your Profile",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "Name",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: namecontroller,
//                   maxLength: 10,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//               ),
//               Text(
//                 "About Me",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: aboutmecontroller,
//                   maxLength: 20,
//                   decoration: InputDecoration(border: OutlineInputBorder()),
//                 ),
//               ),
//               Text(
//                 "Skill",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: skillcontroller,
//                   maxLength: 10,
//                   decoration: InputDecoration(border: OutlineInputBorder()),
//                 ),
//               ),
//               Text(
//                 "Qualification",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: qualificationcontroller,
//                   maxLength: 20,
//                   decoration: InputDecoration(border: OutlineInputBorder()),
//                 ),
//               ),
//               Text(
//                 "Experience",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: experiencecontroller,
//                   maxLength: 20,
//                   decoration: InputDecoration(border: OutlineInputBorder()),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _buildPriceField(label: "Age", hintText: "Eg : 23"),
//                   _buildGenderDropdown(),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPriceField({required String label, required String hintText}) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width / 2, // Half the screen width
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: TextFormField(
//           controller: agecontroller,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             labelText: label,
//             hintText: hintText,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildGenderDropdown() {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width / 3, // Half the screen width
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             labelText: "Gender",
//           ),
//           value: _selectedGender,
//           items: ["Male", "Female", "Others"]
//               .map((gender) => DropdownMenuItem<String>(
//                     value: gender,
//                     child: Text(gender),
//                   ))
//               .toList(),
//           onChanged: (newValue) {
//             setState(() {
//               _selectedGender = newValue;
//             });
//           },
//         ),
//       ),
//     );
//   }
// }
