import 'package:flutter/material.dart';

class mess {
  final String name;
  final String? iconUrl;
  final String days;

  const mess({required this.name, this.iconUrl, required this.days});
}

class smess extends StatelessWidget {
  const smess({super.key});

  @override
  Widget build(BuildContext context) {
    final List<mess> channels = [
      mess(
          name: "Design by Sarah",
          iconUrl: "asset/Ellipse 9.png",
          days: "1 day ago"),
      mess(
          name: "Cleaning by Paul",
          iconUrl: "asset/Ellipse 9.png",
          days: "2 day ago"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Messages"),
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
              itemCount: channels.length,
              itemBuilder: (context, index) {
                final channel = channels[index];
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
                    subtitle: Text("${channel.days} Members"),
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
