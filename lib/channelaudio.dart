import 'package:flutter/material.dart';

class AudioItem {
  final String name;
  final String imagePath;

  AudioItem({required this.name, required this.imagePath});
}

class caudio extends StatelessWidget {
  caudio({super.key});

  final List<AudioItem> audioData = [
    AudioItem(name: "Audio 1.mp3", imagePath: "assets/images/audio_1.jpg"), // Assuming images in assets/images
    AudioItem(name: "Audio 2.wav", imagePath: "assets/images/audio_2.jpg"),
    AudioItem(name: "Audio 3.ogg", imagePath: "assets/images/audio_3.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light background
      body: ListView.builder(
        itemCount: audioData.length,
        itemBuilder: (context, index) {
          final AudioItem audio = audioData[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Dismissible( // Enable swipe-to-delete
              key: UniqueKey(),
              background: Container(
                color: Colors.red,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              onDismissed: (direction) => print("Audio Deleted: ${audio.name}"),
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
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      audio.imagePath,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, exception, stackTrace) {
                        return Icon(
                          Icons.music_note, // Placeholder for missing image
                          size: 32.0,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                  title: Text(
                    audio.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                    ),
                  ),
                  onTap: () => print("Playing Audio: ${audio.name}"), // Placeholder for audio playback
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.play_arrow),
                        onPressed: () => print("Playing Audio: ${audio.name}"), // Placeholder for play button
                      ),
                      IconButton(
                        icon: Icon(Icons.more_vert), // Menu for potential options (pause, stop)
                        onPressed: () => print("Open Audio Options for ${audio.name}"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
