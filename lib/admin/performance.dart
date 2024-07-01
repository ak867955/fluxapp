import 'package:flutter/material.dart';

class Performance extends StatefulWidget {
  const Performance({super.key});

  @override
  State<Performance> createState() => _PerformanceState();
}

class _PerformanceState extends State<Performance> {
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
                  buildPerformanceCard(
                      title: 'App Speed', value: 'Fast', change: '+5%'),
                  buildPerformanceCard(
                      title: 'Uptime', value: '99%', change: '+5%'),
                  buildPerformanceCard(
                      title: 'Error Rate', value: 'Low', change: '+5%'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Card buildPerformanceCard(
      {required String title, required String value, required String change}) {
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
                Text(change, style: TextStyle(color: Colors.teal)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
