import 'package:flutter/material.dart';

class logout extends StatelessWidget {
  const logout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Logout Confirmation'),
                content: Text('Are you sure you want to log out?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle successful logout (e.g., navigate to login screen)
                      Navigator.pop(context); // Close the dialog
                      Navigator.pushReplacementNamed(context, '/login'); // Replace current screen with login screen (assuming your login route is named '/login')
                    },
                    child: Text('Logout'),
                  ),
                ],
              ),
            );
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}
