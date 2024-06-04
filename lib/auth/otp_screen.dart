import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flux/fifthpage.dart';
import 'package:pinput/pinput.dart';

class OtpScreenok extends StatelessWidget {
  final String verificationId;
  final String mobileNumber;
  OtpScreenok({
    super.key,
    required this.verificationId,
    required this.mobileNumber,
  });

  final _formState = GlobalKey<FormState>();
  final otpController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Center(
                    child: Text(
                      "OTP Verification",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 63, 69, 104),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(
                    indent: 30,
                    endIndent: 30,
                    thickness: 2,
                    color: Color.fromARGB(110, 100, 100, 100),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      """Enter the verification code that we just sent to $mobileNumber!""",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Center(
                    child: Pinput(
                      length: 6,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the OTP";
                        } else {
                          return null;
                        }
                      },
                      controller: otpController,
                      defaultPinTheme: PinTheme(
                        width: 56,
                        height: 56,
                        textStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color.fromARGB(255, 63, 69, 104),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          backgroundColor: Color.fromARGB(255, 6, 155, 236),
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async {
                          if (_formState.currentState!.validate()) {
                            try {
                              PhoneAuthCredential credential =
                                  PhoneAuthProvider.credential(
                                verificationId: verificationId,
                                smsCode: otpController.text,
                              );

                              // Sign the user in with the credential
                              await auth.signInWithCredential(credential);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => page5(),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Failed to verify OTP: $e'),
                                ),
                              );
                            }
                          }
                        },
                        child: Text("Submit"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // Add logic to resend OTP
                      },
                      child: Text(
                        "Resend OTP",
                        style: TextStyle(
                          color: Color.fromARGB(255, 6, 155, 236),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
