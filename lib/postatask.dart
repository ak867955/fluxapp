import 'package:flutter/material.dart';

class ptask extends StatefulWidget {
   ptask({super.key});

  @override
  State<ptask> createState() => _ptaskState();
}

class _ptaskState extends State<ptask> {
  final profileSections = [
    'Title',
    'Description',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Service"),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new_outlined)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPriceField(label: "Price", hintText: "200 Rs"),
                _buildPriceField(label: "Duration", hintText: "2 Hrs"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: () {}, child: Text("Add Photos")),
                Icon(Icons.add_box_rounded),
              ],
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Post Service"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceField({required String label, required String hintText}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2, // Half the screen width
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          maxLength: 10,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: label,
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}
