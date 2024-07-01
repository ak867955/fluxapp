import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flux/chatpage.dart';
import 'package:flux/model/myprofilemodel.dart';
import 'package:url_launcher/url_launcher.dart';

class ServicePost {
  final String avatarUrl;
  final String serviceName;
  final String imageUrl;
  final String price;
  final String time;
  final String serviceDetails;
  final String uid;

  const ServicePost({
    required this.avatarUrl,
    required this.serviceName,
    required this.imageUrl,
    required this.price,
    required this.time,
    required this.serviceDetails,
    required this.uid,
  });

  factory ServicePost.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return ServicePost(
      avatarUrl: '', // Assuming avatarUrl is not available in your Firestore data
      serviceName: data['Title'] ?? '',
      imageUrl: data['ImageUrl'] ?? '',
      price: data['Price'].toString(), // Convert price to string
      time: data['Duration'].toString() + ' Hr', // Convert duration to string and add unit
      serviceDetails: data['Description'] ?? '',
      uid: data['Uid'],
    );
  }
}

class ServiceCategories extends StatefulWidget {
  final String selectedCategory;

  const ServiceCategories({Key? key, required this.selectedCategory}) : super(key: key);

  @override
  State<ServiceCategories> createState() => _ServiceCategoriesState();
}

class _ServiceCategoriesState extends State<ServiceCategories> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Myprofilemodel? currentUserModel;

  @override
  void initState() {
    super.initState();
    fetchCurrentUserProfile().then((user) {
      setState(() {
        currentUserModel = user;
      });
    });
  }

  Future<Myprofilemodel?> fetchCurrentUserProfile() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Profile Info")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (snapshot.exists) {
      return Myprofilemodel.fromData(snapshot.data()!);
    }
    return null;
  }

  Stream<List<ServicePost>> _getServicePosts() {
    return _firestore
        .collection('Post Service Info')
        .where('Category', isEqualTo: widget.selectedCategory)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => ServicePost.fromFirestore(doc)).toList();
    });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<Myprofilemodel?> getProfile(String uid) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Profile Info')
        .doc(uid)
        .get();
    if (snapshot.exists) {
      return Myprofilemodel.fromData(snapshot.data()!);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<ServicePost>>(
        stream: _getServicePosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No posts available'));
          }

          final posts = snapshot.data!;

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];

              return FutureBuilder<Myprofilemodel?>(
                future: getProfile(post.uid),
                builder: (context, userProfileSnapshot) {
                  if (userProfileSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (userProfileSnapshot.hasError) {
                    return Center(child: Text('Error: ${userProfileSnapshot.error}'));
                  }
                  if (!userProfileSnapshot.hasData) {
                    return const Center(child: Text('Profile not found'));
                  }

                  final userProfile = userProfileSnapshot.data!;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  userProfile.url ?? 'assets/profile_placeholder.png',
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      post.serviceName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${post.time} | ${post.price}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (post.imageUrl.isNotEmpty)
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: NetworkImage(post.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          const SizedBox(height: 10),
                          Text(post.serviceDetails),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatPage(
                                        senderProfileModel: userProfile,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.chat,color: Colors.white),
                                label: const Text("Chat",style: TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  _makePhoneCall(userProfile.phoneNumber);
                                },
                                icon: const Icon(Icons.call),
                                label: const Text("Call"),
                                style: ElevatedButton.styleFrom(
                                  // backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
