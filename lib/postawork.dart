import 'package:flutter/material.dart';

class pwork extends StatelessWidget {
  const pwork({super.key});

  @override
  Widget build(BuildContext context) {
    final profileSections = [
      'Title',
      'Description',
      'Budget',
      'Deadline',
      'Skills',
      'Choose Category',
      'Level',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Post Work"),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: profileSections.length,
              itemBuilder: (context, index) {
                final section = profileSections[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        section,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        maxLength: 10,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            Center(child: ElevatedButton(onPressed: (){}, child: Text("Post a Work")))
          ],
        ),
      ),
    );
  }
}
