import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flux/channels.dart';
import 'package:flux/chat.dart';
import 'package:flux/mychannels.dart';
import 'package:flux/service.dart';
import 'package:flux/worknow.dart';

class bottomnavipage extends StatefulWidget {
  final int initialIndex;

  const bottomnavipage({Key? key, required this.initialIndex}) : super(key: key);

  @override
  State<bottomnavipage> createState() => _bottomnavipageState();
}

class _bottomnavipageState extends State<bottomnavipage> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final List<Widget> _pages = [
    const Chat(),
    const channels(),
    worknow(),
    ServiceScreen(),
    // const mychannels(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Channels',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Work Now',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.spa),
            label: 'Services',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.star),
          //   label: 'My Channels',
          // ),
        ],
        selectedItemColor: Color.fromRGBO(8, 38, 76, 1), // Adjust to match your color scheme
        unselectedItemColor: Colors.grey[600], // Adjust to match your color scheme
        selectedFontSize: 12, // Adjust font size
        unselectedFontSize: 12, // Adjust font size
        type: BottomNavigationBarType.fixed, // Ensure all items are always visible
      ),
    );
  }
}
