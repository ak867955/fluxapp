import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class mediafiles extends StatelessWidget {
  const mediafiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          children: [
            // Container with rounded corners at the bottom
            Container(
              height: 220.0,
              width: 400.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
            ),
            // Position the GridView on top of the container
            Positioned.fill(
              child: GridView.count(
                crossAxisCount: 3,
                children: [
                  mediaFile(
                    icon: Icon(Icons.file_copy),
                    text: 'File',
                    onPressed: () {},
                  ),
                  mediaFile(
                    icon: Icon(Icons.audiotrack),
                    text: 'Audio',
                    onPressed: () {},
                  ),
                  mediaFile(
                    icon: Icon(Icons.photo_library),
                    text: 'Gallery',
                    onPressed: () {},
                  ),
                  mediaFile(
                    icon: Icon(Icons.contacts),
                    text: 'Contacts',
                    onPressed: () {},
                  ),
                  mediaFile(
                    icon: Icon(Icons.location_on),
                    text: 'Location',
                    onPressed: () {},
                  ),
                  mediaFile(
                    icon: Icon(Icons.payment),
                    text: 'Payment',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ));
  }

  Widget mediaFile(
      {required Icon icon,
      required String text,
      required VoidCallback onPressed}) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(10.0), // Add spacing between tiles
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(height: 10),
            Text(
              text,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      onTap: onPressed,
    );
  }
}
