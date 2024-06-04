import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import for launching links

class LinkItem {
  final String name;
  final String url; // Changed to url for actual link storage

  LinkItem({required this.name, required this.url});
}

class clink extends StatelessWidget {
  clink({super.key});

  final List<LinkItem> linkData = [
    LinkItem(
        name: "Link 1",
        url: "https://www.example.com/link1"), // Replace with your actual links
    LinkItem(name: "Link 2", url: "https://www.example.com/link2"),
    LinkItem(name: "Link 3", url: "https://www.example.com/link3"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light background
      body: ListView.builder(
        itemCount: linkData.length,
        itemBuilder: (context, index) {
          final LinkItem link = linkData[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1.0,
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: ListTile(
                leading: Icon(
                  Icons.link, // Link icon
                  size: 32.0,
                  color: Colors.teal,
                ),
                title: Text(
                  link.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.open_in_new), // Open in new tab icon
                  onPressed: () => _launchURL(link.url),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
