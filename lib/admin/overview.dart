import 'package:flutter/material.dart';
import 'package:flux/data/helperprovider.dart';
import 'package:provider/provider.dart';

class Overview extends StatefulWidget {
  const Overview({Key? key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                // Wrap the cards for responsive layout
                spacing: 20, // spacing between cards
                runSpacing: 20, // spacing between rows of cards
                children: [
                  Consumer<HelperProvider>(
                    builder: (context, helper, child) {
                      return StreamBuilder(
                        stream: helper.getUserLenght(),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState==ConnectionState.waiting){
                            return CircularProgressIndicator();
                          }



                          return buildPerformanceCard(
                              title: 'Total Users',
                              value: snapshot.data.toString() ,
                              );
                        },
                      );
                    },
                  )
                  // buildPerformanceCard(
                  //     title: 'Active Users', value: '2800', change: '+5%'),
                  // buildPerformanceCard(
                  //     title: 'Daily Active Users',
                  //     value: '1200',
                  //     change: '+5%'),
                  // buildPerformanceCard(
                  //     title: 'App Speed', value: 'Fast', change: '+5%'),
                  // buildPerformanceCard(
                  //     title: 'Uptime', value: '99%', change: '+5%'),
                  // buildPerformanceCard(
                  //     title: 'Error Rate', value: 'Low', change: '+5%'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Card buildPerformanceCard(
      {required String title, required String value,  }) {
    return Card(
      color: Color(0xffe9eef3), // #e9eef3 color
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value, style: TextStyle(fontSize: 20)),
                 
              ],
            ),
          ],
        ),
      ),
    );
  }
}
