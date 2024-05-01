import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class payment extends StatefulWidget {
  const payment({super.key});

  @override
  State<payment> createState() => _paymentState();
}

class _paymentState extends State<payment> {
  int payment = 0;
  @override
  Widget build(BuildContext context) {
    int paymentmethod = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Pay"),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: Icon(Icons.arrow_back),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Amount",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)))),
                ),
                Text(
                  "Add a note",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)))),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Choose Payment Method",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: payment,
                              onChanged: (value) =>
                                  setState(() => payment = value as int),
                            ),
                            // Image.asset(
                            //   'asset/flux-high-resolution-logo-white-transparent.png',
                            //   width: 40,
                            //   height: 40,
                            // ),
                            Text("Google Pay"),
                          ],
                        ),
                        Text("Pay securely using Google Pay")
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Radio(
                                  value: 2,
                                  groupValue: payment,
                                  onChanged: (value) =>
                                      setState(() => payment = value as int),
                                ),
                                // Image.asset(
                                //   'asset/flux-high-resolution-logo-white-transparent.png',
                                //   width: 40,
                                //   height: 40,
                                // ),
                                Text("Amazon Pay"),
                              ],
                            ),
                            Text("Pay securely using Amazon Pay"),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                ElevatedButton(onPressed: () {}, child: Text('Pay now'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
