import 'package:flutter/material.dart';
import 'package:flux/channels.dart';
import 'package:flux/chat.dart';
import 'package:flux/mychannels.dart';
import 'package:flux/service.dart';
import 'package:flux/worknow.dart';

class bottomnavipage extends StatefulWidget {
  int indexnum = 0;

  bottomnavipage({super.key, required this.indexnum});

  @override
  State<bottomnavipage> createState() => _bottomnavipageState();
}

class _bottomnavipageState extends State<bottomnavipage> {
  final _pages = [
    const chat(),
    const channels(),
    worknow(),
    service(),
    const channels(),
    const mychannels()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[widget.indexnum],
      bottomNavigationBar: myNav(
        index: widget.indexnum,
        onTap: (index) {
          setState(() {
            widget.indexnum = index;
          });
        },
      ),
    );
  }
}

Widget myNav({
  int? index,
  void Function(int)? onTap,
  selectedcolor,
}) {
  return BottomNavigationBar(
    showUnselectedLabels: true,
    currentIndex: index!,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.black,
    showSelectedLabels: true,
    onTap: onTap,
    items: const [
      BottomNavigationBarItem(
          icon: Icon(Icons.chat), label: 'Chat', backgroundColor: Colors.white),
      BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Channels',
          backgroundColor: Colors.white),
      BottomNavigationBarItem(
          icon: Icon(Icons.work),
          label: 'Worknow',
          backgroundColor: Colors.white),
      BottomNavigationBarItem(
          icon: Icon(Icons.spa),
          label: 'Services',
          backgroundColor: Colors.white),
    ],
  );
}
