import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flux/fifthpage.dart';

class otp extends StatelessWidget {
  const otp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Center(
              child: Text("Enter Verification Code",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 0; i < 6; i++) buildOtpField(),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Resend OTP",
            style: TextStyle(color: Colors.blue),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {},
            child: Text("Didn't Receive Code? Help"),
          ),
          SizedBox(height: 20),
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => page5()));
            },
            label: Text('Next'),
            icon: Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }

  Widget buildOtpField() {
    return Container(
      width: 50,
      height: 50,
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        obscureText: true,
       // maxLength: 1,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
