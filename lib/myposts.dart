import 'package:flutter/material.dart';

class MyPosts extends StatelessWidget {
  const MyPosts({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for demonstration
    final List<Map<String, String>> myServices = [
      {
        "title": "Plumbing Service",
        "description": "Fixing leaks and installing pipes.",
        "price": "\$50",
        "category": "Plumbing",
      },
      {
        "title": "Electrical Service",
        "description": "Repairing electrical issues.",
        "price": "\$100",
        "category": "Electrician",
      },
      {
        "title": "Taxi Service",
        "description": "24/7 taxi service.",
        "price": "\$30",
        "category": "Taxi",
      },
      // Add more services as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("My Posts",style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded, color: Colors.white),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: myServices.length,
        itemBuilder: (context, index) {
          final service = myServices[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              title: Text(
                service['title']!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service['description']!,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 5),
                  Text(
                    service['price']!,
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                  SizedBox(height: 5),
                  Text(
                    service['category']!,
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
