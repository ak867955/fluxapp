import 'package:flutter/material.dart';
import 'package:flux/postacontest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flux/model/contestmodel.dart';
import 'package:flux/utils/string.dart';

class ContestsPage extends StatefulWidget {
  const ContestsPage({Key? key}) : super(key: key);

  @override
  State<ContestsPage> createState() => _ContestsPageState();
}

class _ContestsPageState extends State<ContestsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Contestmodel>> _getContests() {
    return _firestore.collection('Contests').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Contestmodel.fromData(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contest Details", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(8, 38, 76, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pcont()),
              );
            },
            child: const Text(
              "Create",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: StreamBuilder<List<Contestmodel>>(
        stream: _getContests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No contests available'));
          }

          final contests = snapshot.data!;

          return ListView.builder(
            itemCount: contests.length,
            itemBuilder: (context, index) {
              final contest = contests[index];
              return ContestCard(contest: contest);
            },
          );
        },
      ),
    );
  }
}

class ContestCard extends StatelessWidget {
  final Contestmodel contest;

  const ContestCard({Key? key, required this.contest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final uid = contest.uid;
    final Stream<DocumentSnapshot> userStream =
        _firestore.collection('Profile Info').doc(uid).snapshots();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: userStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.data() == null) {
                  return const Text('User data not available');
                }
                final userData = snapshot.data!.data() as Map<String, dynamic>;
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(userData['image'] ?? 'https://via.placeholder.com/150'),
                  ),
                  title: Text(
                    
                    userData['name'] ?? 'No Name',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Text(
              contest.title ?? 'No Title',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(contest.description ?? 'No Description'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Join"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text("Delete"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class PostContestPage extends StatelessWidget {
//   const PostContestPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Post a Contest"),
//         backgroundColor: const Color.fromRGBO(8, 38, 76, 1),
//       ),
//       body: const Center(
//         child: Text(
//           'Post Contest Page',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }
