import 'package:flutter/material.dart';
import 'package:flux/verification.dart'; // Assuming verification.dart defines the verification UI
import 'package:flux/workexperience.dart'; // Assuming workexperience.dart defines the work experience UI

class acc extends StatelessWidget {
  const acc({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Use theme for consistent styling

    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Your Account"),
        backgroundColor: theme.primaryColor, // Use theme color
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView( // Wrap content in SingleChildScrollView for scrollable content
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            Text(
              "Provide Identification",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Help us verify your identity with a government-issued ID.",
                ),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => verification()),
                  ),
                  child: const Text("Verify"),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Text(
              "Verify Work Experience",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Share your work history and education.",
                ),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => workex()),
                  ),
                  child: const Text("Verify"),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _showConfirmationDialog(context),
                  child: const Text("Continue Later"),
                ),
                ElevatedButton(
                  onPressed: () => _showSuccessDialog(context),
                  child: const Text("Done"),
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
          title: const Text('Confirmation'),
          content: const Text('Are you sure you want to continue later?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst), // Close dialog and pop all screens
              child: const Text('Continue Later'),
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
          title: const Text('Success'),
          content: const Text('Your account verification is in progress.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
