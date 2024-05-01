import 'package:flutter/material.dart';

class dashboard extends StatelessWidget {
  const dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCard(
                      title: "Earnings", subTitle: "This Month's Earnings"),
                  _buildCard(
                      title: "Paid to You", subTitle: "Total Amount Received"),
                                    _buildCard(
                      title: "Outstanding", subTitle: "Total Amount Received"),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Text("Ongoing Projects",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Text("Bakery logo design"),
          Text("Due in 2 days"),
          Text("Graphic % Design"),
        ],
      ),
    );
  }

  Widget _buildCard({required String title, required String subTitle}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Prevents card from expanding
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              subTitle,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
