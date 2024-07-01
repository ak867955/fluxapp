// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flux/model/myprofilemodel.dart';

// class AddMembers extends StatefulWidget {
//   const AddMembers({super.key});

//   @override
//   State<AddMembers> createState() => _AddMembersState();
// }

// class _AddMembersState extends State<AddMembers> {
//   TextEditingController _searchController = TextEditingController();
//   List<Myprofilemodel> selectedUsers = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Members"),
//         backgroundColor: Color.fromRGBO(8, 38, 76, 1),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: "Search...",
//                 prefixIcon: Icon(Icons.search),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 15),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                   borderSide: BorderSide(
//                     color: Colors.grey,
//                     width: 0.5,
//                   ),
//                 ),
//               ),
//               onChanged: (text) => setState(() {}), // Update search text
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance.collection('Profile Info').snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }

//                 if (!snapshot.hasData) {
//                   return const Center(
//                     child: Text("No users found"),
//                   );
//                 }

//                 List<Myprofilemodel> listOfUsers = snapshot.data!.docs.map((doc) {
//                   return Myprofilemodel.fromData(doc.data() as Map<String, dynamic>);
//                 }).toList();

//                 String query = _searchController.text.toLowerCase();
//                 List<Myprofilemodel> filteredUsers = listOfUsers.where((user) {
//                   return user.firstname.toLowerCase().contains(query) ||
//                          user.secondname.toLowerCase().contains(query);
//                 }).toList();

//                 return ListView.builder(
//                   itemCount: filteredUsers.length,
//                   itemBuilder: (context, index) {
//                     final user = filteredUsers[index];
//                     final isSelected = selectedUsers.contains(user);

//                     return ListTile(
//                       title: Text('${user.firstname} ${user.secondname}'),
//                       leading: CircleAvatar(
//                         backgroundImage: NetworkImage(user.url),
//                       ),
//                       trailing: Checkbox(
//                         value: isSelected,
//                         onChanged: (value) {
//                           setState(() {
//                             if (value!) {
//                               selectedUsers.add(user);
//                             } else {
//                               selectedUsers.remove(user);
//                             }
//                           });
//                         },
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 // Handle add members logic (add selected users to a channel or group)
//                 print("Selected users: ${selectedUsers.map((user) => user.firstname).toList()}");
//               },
//               child: Text("Add Members"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
