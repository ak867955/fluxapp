import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flux/auth/otp_screen.dart';
import 'package:flux/chat.dart';
import 'package:flux/otppage.dart';

class pnumber extends StatefulWidget {
  pnumber({super.key});

  @override
  State<pnumber> createState() => _pnumberState();
}

class _pnumberState extends State<pnumber> {
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final coundrycode = '+91';

  Future<void> phoneAuth() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '$coundrycode${phoneController.text}',
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Verification Failed  this snackbar: ${e.message}")));
          },
          codeSent: (String verificationId, int? resendToken) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OtpScreen(
                        verificationid: verificationId,
                        mobilenumber: '$coundrycode${phoneController.text}')));
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInWithPhoneCredential(
      BuildContext context, PhoneAuthCredential credential) async {
    try {
      final authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      // Check if the user is signed in
      if (authResult.user != null) {
        // User signed in successfully, navigate to the next screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => chat(),
          ),
        );
      } else {
        // Handle sign in failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign in failed Try Again'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  Future<void> initiatePhoneVerification(BuildContext context) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '$coundrycode ${phoneController.text}',
        verificationCompleted: (PhoneAuthCredential credential) {
          // This callback will be invoked in case of instant verification.
          // You can directly sign in the user here.
          signInWithPhoneCredential(context, credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle verification failure
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Verification failed: ${e.message}'),
            ),

          
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          // Navigate to OTP screen after code is sent
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpScreen(
                    verificationid: verificationId,
                    mobilenumber: '$coundrycode${phoneController.text}')),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle timeout
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Please Confirm You'r Country Code and Enter You'r Mobile Number"),
              ),
              SizedBox(height: 30),
              SizedBox(
                child: TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blue, width: 3),
                      ),
                      label: Text("Enter Phone Number")),
                ),
                width: 350,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      phoneAuth();
                    }
                  },
                  child: Text("Send OTP"))
            ],
          ),
        ),
      ),
    );
  }
}
