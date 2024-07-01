import 'package:flutter/material.dart';
import 'package:flux/model/postworkmodel.dart';

class WorkDetailsScreen extends StatelessWidget {
  final Postworkmodel work;

  const WorkDetailsScreen({Key? key, required this.work}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(work.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(work.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text(work.description),
            SizedBox(height: 16),
            Text(work.level),
            SizedBox(height: 16),
            Text(work.level),
            SizedBox(height: 16),
            Text(work.level),
            SizedBox(height: 16),
            Text(work.level),
            SizedBox(height: 16),
            Text(work.subCategory),
            SizedBox(height: 16),
            Text(work.level),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
