import 'package:flutter/material.dart';

class clist extends StatelessWidget {
  const clist({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Channel> channels = [
  
      Channel(name: "Flutter Dev", iconUrl: "assets/flutter_dev.png",price: 199),
      Channel(name: "Dart Lang", iconUrl: "assets/dart_lang.png",price: 199),
      Channel(name: "Android Dev", iconUrl: "assets/android_dev.png",price: 199),

    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("FLUX"),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: Icon(Icons.arrow_back),
        actions: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(backgroundColor: Colors.white),
          ) 
        ],
      ),
      body: Column(
        children: [
                    Row(
            children: [
              TextButton(onPressed: (){}, child: Text("All")),
              TextButton(onPressed: (){}, child: Text("Free",style: TextStyle(color: Colors.black))),
              TextButton(onPressed: (){}, child: Text("Paid",style: TextStyle(color: Colors.black))),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search Channels",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {

              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: channels.length,
              itemBuilder: (context, index) {
                final channel = channels[index];
                return ListTile(
                  leading: (channel.iconUrl != null)
                      ? CircleAvatar(
                          backgroundImage: AssetImage(channel.iconUrl!),
                        )
                      : Icon(Icons.chat),
                  title: Text(channel.name),
                  subtitle: (channel.price !=null) ? Text("Price : \ ${channel.price}") : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Channel {
  final String name;
  final String? iconUrl;
  final double? price;

  const Channel({required this.name, this.iconUrl,this.price});
}
