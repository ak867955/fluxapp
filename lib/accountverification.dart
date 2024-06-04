import 'package:flutter/material.dart';
import 'package:flux/verification.dart'; // Assuming verification.dart defines the verification UI
import 'package:flux/workexperience.dart'; // Assuming workexperience.dart defines the work experience UI

class acc extends StatefulWidget {
  const acc({Key? key}) : super(key: key);

  @override
  State<acc> createState() => _accState();
}

class _accState extends State<acc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Verify Your Account",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: Colors.white,),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.0),
            Text(
              "Provide Identification",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              "Help us verify your identity with a government-issued ID.",
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => verification()),
              ),
              child: Text("Verify", style: TextStyle(fontSize: 16.0)),
            ),
            SizedBox(height: 24.0),
            Text(
              "Verify Work Experience",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              "Share your work history and education.",
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => workex()),
              ),
              child: Text("Verify", style: TextStyle(fontSize: 16.0)),
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _showConfirmationDialog(context),
                  child: Text("Continue Later", style: TextStyle(fontSize: 16.0)),
                ),
                ElevatedButton(
                  onPressed: () => _showSuccessDialog(context),
                  child: Text("Done", style: TextStyle(fontSize: 16.0)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation', style: TextStyle(fontSize: 18.0)),
          content: Text('Are you sure you want to continue later?', style: TextStyle(fontSize: 16.0)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(fontSize: 16.0)),
            ),
            TextButton(
              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
              child: Text('Continue Later', style: TextStyle(fontSize: 16.0)),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success', style: TextStyle(fontSize: 18.0)),
          content: Text('Your account verification is in progress.', style: TextStyle(fontSize: 16.0)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK', style: TextStyle(fontSize: 16.0)),
            ),
          ],
        );
      },
    );
  }
}
