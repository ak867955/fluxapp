import 'package:flutter/material.dart';
import 'package:flux/accountverification.dart';
import 'package:flux/profile.dart';
import 'package:flux/createprofile.dart';
import 'package:flux/savedmessage.dart';
import 'package:flux/settings.dart';
import 'package:flux/verification.dart';

class drawer extends StatelessWidget {
  const drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 16,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(8, 38, 76, 1),
            ),
            accountName: Text("John"),
            accountEmail: Text("+91 8973656783"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("asset/Ellipse 22.png"),
            ),
          ),
          ListTile(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => myprofile())),
            leading: IconButton(
              onPressed: null, // Remove the redundant onPressed from IconButton
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
            ),
            title: Text(
              "Profile",
              style: TextStyle(fontSize: 18),
            ),
            textColor: Colors.black,
          ),
          ListTile(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => settings())),
            leading: IconButton(
              onPressed: null, // Remove the redundant onPressed from IconButton
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
            ),
            title: Text(
              "Settings",
              style: TextStyle(fontSize: 18),
            ),
            textColor: Colors.black,
          ),
          ListTile(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => smess())),
            leading: IconButton(
              onPressed: null, // Remove the redundant onPressed from IconButton
              icon: Icon(
                Icons.save_rounded,
                color: Colors.black,
              ),
            ),
            title: Text(
              "Saved Messages",
              style: TextStyle(fontSize: 18),
            ),
            textColor: Colors.black,
          ),
          ListTile(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => verification())),
            leading: IconButton(
              onPressed: null, // Remove the redundant onPressed from IconButton
              icon: Icon(
                Icons.verified,
                color: Colors.black,
              ),
            ),
            title: Text(
              "My KYC",
              style: TextStyle(fontSize: 18),
            ),
            textColor: Colors.black,
          ),
          ListTile(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => acc())),
            leading: IconButton(
              onPressed: null, // Remove the redundant onPressed from IconButton
              icon: Icon(
                Icons.work,
                color: Colors.black,
              ),
            ),
            title: Text(
              "Work Now",
              style: TextStyle(fontSize: 18),
            ),
            textColor: Colors.black,
          ),
          ListTile(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => profile())),
            leading: IconButton(
              onPressed: null, // Remove the redundant onPressed from IconButton
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ),
            ),
            title: Text(
              "Log Out",
              style: TextStyle(fontSize: 18),
            ),
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
