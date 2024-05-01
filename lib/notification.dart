import 'package:flutter/material.dart';

class notification {
  final String name;
  final String? iconUrl;
  final String job;
  final String days;

  const notification(
      {required this.name,
      this.iconUrl,
      required this.job,
      required this.days});
}

class noti extends StatelessWidget {
  const noti({super.key});

  @override
  Widget build(BuildContext context) {
    final List<notification> noti = [
      notification(
          name: "Sarah",
          iconUrl: "assets/flutter_dev.png",
          job: "Logo Designer",
          days: "1 day ago"),
      notification(
          name: "Paul",
          iconUrl: "assets/dart_lang.png",
          job: "UI/UX Designer",
          days: "1 day ago"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, // Go back
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        centerTitle: true,
        actions: [Icon(Icons.search)],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: noti.length,
              itemBuilder: (context, index) {
                final channel = noti[index];
                return Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: ListTile(
                    leading: (channel.iconUrl != null)
                        ? CircleAvatar(
                            backgroundImage: AssetImage(channel.iconUrl!),
                          )
                        : Icon(Icons.chat),
                    title: Text(channel.name),
                    subtitle: Text("${channel.job} Members"),
                    trailing:
                        ElevatedButton(onPressed: () {}, child: Text("View")),
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
