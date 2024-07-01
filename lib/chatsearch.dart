// import 'package:flutter/material.dart';
// import 'package:flux/chatpage.dart';
// import 'package:flux/profile.dart';


// class ChatSearch extends StatelessWidget {
//   const ChatSearch({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold( 
//       appBar: AppBar(
//         title: Text("FLUX",style: TextStyle(color: Colors.white)),
//         backgroundColor: Color.fromRGBO(8, 38, 76, 1),
//         leading: IconButton(onPressed: (){
//           Navigator.pop(context);
//         }, icon: Icon(Icons.arrow_back,color: Colors.white)),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: CircleAvatar(
//               backgroundColor: Colors.white,
//               backgroundImage: AssetImage("asset/Ellipse 22.png"),
//               child: InkWell(
//                 onTap: () => Navigator.push(
//                     context, MaterialPageRoute(builder: (context) => ChatOpponentProfile())),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Add the TextField here
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: "Search...",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                 ),
//               ),
//             ),
//             // Existing ListView.builder
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 20,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text("PERSON $index"),
//                     subtitle: Text("Message $index"),
//                     leading: CircleAvatar(
//                       radius: 30,
//                       backgroundImage: AssetImage("asset/Ellipse 22.png"), // Replace with your asset path
//                     ),
//                     trailing: Text("1$index:00 PM"),
//                     onTap: () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (context) => ChatPage(), // Replace with your ChatPage widget
//                       //   ),
//                       // );
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
