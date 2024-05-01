import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class page3 extends StatelessWidget {
  const page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Text(
                  "Welcome to Flux SuperApp",
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black, width: 3),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black, width: 3),
                      ),
                      label: Text("Country",style: TextStyle(color: Colors.black),)),
                ),
              ),
            
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black, width: 3),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black, width: 3),
                      ),
                      label: Text("Phone number",style:TextStyle(color: Colors.black),)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black, width: 3),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black, width: 3),
                      ),
                      label: Text("Email",style: TextStyle(color: Colors.black))),
                ),
              ),
              
            ],
            
          )),
          floatingActionButton: FloatingActionButton(
            onPressed: (){},backgroundColor: Colors.black,child: Icon(Icons.send,color: Colors.white,),),
    );
  }
}
