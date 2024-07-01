import 'package:flutter/material.dart';
import 'package:flux/admin/dashboard.dart';
import 'package:flux/dashboard.dart';
import 'package:flux/utils/string.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final _formKey = GlobalKey<FormState>(); // Create a form key for validation
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // Simulated authentication logic (replace with actual backend integration)
  bool _authenticate(String username, String password) {
    return username == 'admin' && password == 'secret';
  }

  final adminuid = 'DoQJSC5KbnOxjrus4JgcwpXBnOB3';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FLUX", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.help)),
        ],
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Text("Welcome to Flux Admin"),
                    SizedBox(height: 20),
                    Text(
                      "Log in or sign up for an account to manage your team's"
                      "messaging & working experience.",
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 3),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                 autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _passwordController,
                obscureText: true, // Hide password characters
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 3),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String username = _usernameController.text;
                    String password = _passwordController.text;

                    await auth
                        .signInWithEmailAndPassword(
                            email: username, password: password)
                        .then((value) {
                      if (value.user!.uid == adminuid) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminDashboard(),
                            ),
                            (route) => false);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('ERRO '),
                          ),
                        );
                      }
                    });
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color.fromRGBO(8, 38, 76, 1), // Change color to blue accent
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Set corner radius to 20
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(
                    Size(300, 50), // Set width and height
                  ),
                ),
                child: Text("Log In", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
