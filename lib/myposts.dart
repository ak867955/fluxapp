import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flux/utils/string.dart';

class MyPosts extends StatelessWidget {
  const MyPosts({super.key});

  Stream<List<Map<String, dynamic>>> _getMyPosts(String userId) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    return _firestore
        .collection('Post Service Info')
        .where('Uid', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<void> _deletePost(String postId) async {
    await FirebaseFirestore.instance
        .collection('Post Service Info')
        .doc(postId)
        .delete();
  }

  Future<void> _showMyDialog(BuildContext context, id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are You Sure Delte The post'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('NO'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('YES'),
              onPressed: () {
                db.collection('Post Service Info').doc(id).delete();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Posts", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<User?>(
        future: FirebaseAuth.instance.authStateChanges().first,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No user found'));
          }

          final user = snapshot.data!;
          return StreamBuilder<List<Map<String, dynamic>>>(
            stream: _getMyPosts(user.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No posts available'));
              }

              final myServices = snapshot.data!;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: myServices.length,
                        itemBuilder: (context, index) {
                          final service = myServices[index];
                          final postId = service[
                              'PostId']; // Ensure PostId exists in your data
                  
                          return Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 16),
                                leading: Image.network(
                                  service['ImageUrl'] ?? '',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.image,
                                        size: 60, color: Colors.grey);
                                  },
                                ),
                                title: Text(
                                  service['Title'] ?? 'No Title',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      service['Description'] ?? 'No Description',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey[600]),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '\$${service['Price']?.toString() ?? '0'}',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey[800]),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      service['Category'] ?? 'No Category',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey[800]),
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                    onPressed: () async {
                                      _showMyDialog(
                                          context, service['ServiceId']);
                                    },
                                    icon: Icon(Icons.delete, color: Colors.red))),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
