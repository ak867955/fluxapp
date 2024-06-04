import 'package:flutter/material.dart';

class application extends StatelessWidget {
  const application({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Application",style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("asset/Ellipse 22.png"),
                      radius: 50,
                    ),
                    SizedBox(height: 20),
                    Text("Katherine", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                    SizedBox(height: 10),
                    Text("Kochi, Ernakulam", style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                    SizedBox(height: 10),
                    Text("Beginner", style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Cover Letter", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 10),
                    Text(
                      "I have been working on the design and development of websites for over 10 years. I can help you create a professional website that is easy to navigate and looks great. I am also experienced in SEO so I can make sure your site ranks well on Google.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text("Rate", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(height: 10),
                        Text("100 rs / hr", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Points", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(height: 10),
                        Text("50 Ps", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Timeline", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(height: 10),
                        Text("2 months", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Portfolio", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage("asset/Rectangle 63.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage("asset/Rectangle 64.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(8, 38, 76, 1),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text("Accept",style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text("Contact",style: TextStyle(color: Colors.black)),
                  ),
                  TextButton(onPressed: (){}, child: Text("Reject"))
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.red,
                  //     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  //   ),
                  //   child: Text("Reject",style: TextStyle(color: Colors.white)),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
