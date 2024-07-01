import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flux/model/myprofilemodel.dart';

class cprofile extends StatefulWidget {
  const cprofile({Key? key}) : super(key: key);

  @override
  State<cprofile> createState() => _cprofileState();
}

class _cprofileState extends State<cprofile> {
  Myprofilemodel? currentUserModel;
  Future<Myprofilemodel?> fetchData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Profile Info")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (snapshot.exists) {
      return currentUserModel = Myprofilemodel.fromData(snapshot.data()!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                NetworkImage(currentUserModel!.url),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '${currentUserModel!.firstname} ${currentUserModel!.secondname}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            currentUserModel!.skill,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cake, color: Colors.black54),
                        SizedBox(width: 5),
                        Text(
                          currentUserModel!.age.toString(),
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(width: 20),
                        Icon(Icons.male, color: Colors.black54),
                        SizedBox(width: 5),
                        Text(
                          currentUserModel!.gender,
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      currentUserModel!.aboutme,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        const Icon(Icons.star, color: Colors.amber),
                        const Icon(Icons.star, color: Colors.amber),
                        const Icon(Icons.star, color: Colors.amber),
                        const Icon(Icons.star_half, color: Colors.amber),
                        const SizedBox(width: 5),
                        Text(
                          "4.8",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.people),
                      title: const Text(
                        "Member Since",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: const Text("2024"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.pentagon_outlined),
                      title: const Text(
                        "Ranking",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: const Text("Master"),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: Text(
                        "My Mood",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 8),
                    Center(
                        child:
                            Text("Sleeping", style: TextStyle(fontSize: 16))),
                    const SizedBox(height: 20),
                    Center(
                      child: Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              minimumSize: Size(250, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              textStyle: TextStyle(fontSize: 18),
                            ),
                            onPressed: () {},
                            child: Text("Block"),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              minimumSize: Size(250, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              textStyle: TextStyle(fontSize: 18),
                            ),
                            onPressed: () {},
                            child: Text("Call"),
                          ),
                          // SizedBox(height: 20),
                          // ElevatedButton(
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: Colors.green,
                          //     minimumSize: Size(250, 50),
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(25),
                          //     ),
                          //     textStyle: TextStyle(fontSize: 18),
                          //   ),
                          //   onPressed: () {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => dashboard()));
                          //   },
                          //   child: const Text("More"),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
