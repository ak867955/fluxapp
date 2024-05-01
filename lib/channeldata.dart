import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class cdata extends StatelessWidget {
  const cdata({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
      body: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 150,
                child: Image.asset("asset/Rectangle 63.png"),
              ),
          Text("Design team",style: TextStyle(fontWeight: FontWeight.bold),),
          Text("Design community"),
          Text("1.2 M subscriber"),

            ],
      ),

    );
  }
}