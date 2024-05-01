import 'package:flutter/material.dart';

class caudio extends StatelessWidget {
caudio({super.key});

  // Replace with your actual audio data (name and image path)
  final List<AudioItem> audioData = [
    AudioItem(name: "Audio 1", imagePath: "asset/pexels-toa-heftiba-şinca-1194420.jpg"),
    AudioItem(name: "Audio 2", imagePath: "asset/pexels-toa-heftiba-şinca-1194420.jpg"),
    AudioItem(name: "Audio 3", imagePath: "asset/pexels-toa-heftiba-şinca-1194420.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: audioData.length,
        itemBuilder: (context, index) {
          final AudioItem audio = audioData[index];
          return ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(audio.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(audio.name),
            // Add functionality to play audio on tap (optional)
            onTap: () => print("Playing audio: ${audio.name}"),
          );
        },
      ),
    );
  }
}

class AudioItem {
  final String name;
  final String imagePath;

  AudioItem({required this.name, required this.imagePath});
}
