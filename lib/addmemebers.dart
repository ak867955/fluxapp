import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class addmem extends StatefulWidget {
  const addmem({super.key});

  @override
  State<addmem> createState() => _addmemState();
}

class _addmemState extends State<addmem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Members"),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
              ),
              onChanged: (text) => setState(() {}), // Update search text
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: contacts.length, // Replace with your contacts data
              itemBuilder: (context, index) {
                final contact = contacts[index];
                final isSelected = contact
                    .isSelected; // Assuming an isSelected flag in your contact model
                return ListTile(
                  title: Text(contact.name),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                        contact.avatarPath), // Replace with avatar path
                  ),
                  trailing: Checkbox(
                    value: isSelected,
                    onChanged: (value) =>
                        setState(() => contact.isSelected = value!),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle add members logic (add selected contacts to channel)
                print("Add members pressed");
              },
              child: Text("Add Members"),
            ),
          ),
        ],
      ),
    );
  }
}

List<Contact> contacts = [
  Contact(
      name: "John Doe", avatarPath: "assets/avatar1.png", isSelected: false),
  Contact(
      name: "Jane Smith", avatarPath: "assets/avatar2.png", isSelected: false),
  Contact(
      name: "Alice Walker",
      avatarPath: "assets/avatar3.png",
      isSelected: false),
  // ... more contacts
];

class Contact {
  final String name;
  final String avatarPath;
  bool isSelected;

  Contact(
      {required this.name, 
      required this.avatarPath, 
      this.isSelected = false});
}
