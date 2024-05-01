import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class pcont extends StatefulWidget {
  const pcont({super.key});

  @override
  State<pcont> createState() => _pcontState();
}

class _pcontState extends State<pcont> {
  String selectedSkill = 'Graphic design';
  String selectedDays = '1 Days';

  List<String> skills = [
    'Graphic design',
    'Branding',
    'Illustration',
    'Logo Design'
  ];
  List<String> days = [
    '1 Days',
    '3 Days',
    '5 Days',
    '7 Days',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Contest"),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: Icon(Icons.arrow_back_ios_new_outlined),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              "Title",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLength: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Title"),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Description",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLength: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Description"),
                ),
              ),
            ),
            Text(
              "Budget",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLength: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Enter Your Budget"),
                ),
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                Text(
                  "Guidelines",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text("Be specific about the skills required for the job"),
                SizedBox(height: 10),
                Text("Use a clear and concise title"),
                SizedBox(height: 10),
                Text("Provide as many details as possible"),
                SizedBox(height: 10),
                Text(
                  "Skill Required",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedSkill,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 18,
                  elevation: 16,
                  underline: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      selectedSkill = newValue!;
                    });
                  },
                  items: skills.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                Text(
                  "Set Deadline",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: selectedDays,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 18,
                  elevation: 16,
                  underline: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      selectedDays = newValue!;
                    });
                  },
                  items: days.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            ElevatedButton(onPressed: () {}, child: Text("Post Your Contest"))
          ],
        ),
      ),
    );
  }
}
