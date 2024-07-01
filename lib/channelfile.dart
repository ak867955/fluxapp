import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatFileItem {
  final String name;
  final String imagePath;
  final Color backgroundColor; // Added for color customization

  ChatFileItem({
    required this.name,
    required this.imagePath,
    this.backgroundColor = Colors.white, // Default white background
  });
}

class cfile extends StatefulWidget {
  cfile({super.key});

  @override
  State<cfile> createState() => _cfileState();
}

class _cfileState extends State<cfile> {
  final List<ChatFileItem> fileData = [
    ChatFileItem(
      name: "File 1.jpg",
      imagePath:
          "assets/images/file_2.pdf", // Assuming images are in assets/images
      // Example custom background
    ),
    ChatFileItem(
      name: "File 2.pdf",
      imagePath:
          "assets/images/file_2.pdf", // Assuming PDFs are represented with icons
    ),
    ChatFileItem(
      name: "File 3.docx",
      imagePath:
          "assets/images/file_3.docx", // Assuming DOCX are represented with icons
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light background
      body: Column(
        children: [
                    Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Search files...',
                filled: true,
                fillColor: Colors.white, 
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // Implement your search logic here
                print("Search query: $value");
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: fileData.length,
              itemBuilder: (context, index) {
                final ChatFileItem file = fileData[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.red,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) => print("File Deleted: ${file.name}"),
                    child: Container(
                      decoration: BoxDecoration(
                        color: file.backgroundColor,
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
                          child: file.imagePath.endsWith('.jpg') ||
                                  file.imagePath.endsWith('.png')
                              ? Image.asset(
                                  file.imagePath,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )
                              : Icon(
                                  Icons
                                      .insert_drive_file, // Generic icon for non-images
                                  size: 32.0,
                                  color: Colors.grey,
                                ),
                        ),
                        title: Text(
                          file.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                        onTap: () => print("Open File: ${file.name}"),
                        trailing: IconButton(
                          icon: Icon(Icons.more_vert), // Menu for potential actions
                          onPressed: () =>
                              print("Open File Options for ${file.name}"),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
