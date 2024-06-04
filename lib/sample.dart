// import 'package:flutter/material.dart';

// void main() {
//   runApp(KonnectApp());
// }

// class KonnectApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Konnect',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       home: KonnectPage(),
//     );
//   }
// }

// class KonnectPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 24),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.white, Colors.grey[200]!],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 'Welcome to',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
//               ),
//               Text(
//                 'Konnect',
//                 style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.purple),
//               ),
//               SizedBox(height: 16),
//               CircleAvatar(
//                 radius: 50,
//                 backgroundImage: NetworkImage('https://via.placeholder.com/100'), // replace with actual image URL
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'Nick Manson',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'nickmanson@konnect.com',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey[600]),
//               ),
//               SizedBox(height: 24),
//               GenderSelection(),
//               SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: () {
//                   // Connect button action
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(horizontal: 48, vertical: 12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(24.0),
//                   ),
//                   backgroundColor: Colors.green,
//                 ),
//                 child: Text(
//                   'Connect',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class GenderSelection extends StatefulWidget {
//   @override
//   _GenderSelectionState createState() => _GenderSelectionState();
// }

// class _GenderSelectionState extends State<GenderSelection> {
//   String? selectedGender;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               selectedGender = 'Male';
//             });
//           },
//           child: GenderOption(
//             icon: Icons.male,
//             label: 'Male',
//             isSelected: selectedGender == 'Male',
//           ),
//         ),
//         SizedBox(width: 32),
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               selectedGender = 'Female';
//             });
//           },
//           child: GenderOption(
//             icon: Icons.female,
//             label: 'Female',
//             isSelected: selectedGender == 'Female',
//           ),
//         ),
//       ],
//     );
//   }
// }

// class GenderOption extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final bool isSelected;

//   const GenderOption({
//     required this.icon,
//     required this.label,
//     required this.isSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Icon(
//           icon,
//           size: 48,
//           color: isSelected ? Colors.blue : Colors.grey,
//         ),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//             color: isSelected ? Colors.blue : Colors.grey,
//           ),
//         ),
//       ],
//     );
//   }
// }
