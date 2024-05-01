import 'package:flutter/material.dart';

class works {
  final String title;
  final String date;
  final String name;
  final double price;

  const works({required this.title,required this.date, required this.name,required this.price});
}

class cowork extends StatelessWidget {
  const cowork({super.key});

  @override
  Widget build(BuildContext context) {
    final List<works> noti = [
      works(title: "Project Title ", date: "Jan 18, 2023",name: "1 day ago",price: 100),
      works(title: "Project Title", date: "Jan 20, 2023",name: "1 day ago",price: 200),
      
    ];

    return Scaffold(
      appBar: AppBar(       
        title: Text("Completed Works"),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: Icon(Icons.arrow_back_ios_new_outlined),
        centerTitle: true,
        actions: [Icon(Icons.search)],

      ),
      body: Column(
        children: [


          Expanded(
            
            child: ListView.builder(
              itemCount: noti.length,
              itemBuilder: (context, index) {
                final cowork = noti[index];
                return ListTile(       
                  title: Text(cowork.title),
                  subtitle: Text(cowork.date),
                 trailing: Column(
                  children: [
                    Text("Client name"),
                    
                  ],
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

