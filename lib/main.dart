// import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flux/chatpage.dart';
import 'package:flux/createprofile.dart';
import 'package:flux/fifthpage.dart';
// import 'package:flux/accountverification.dart';
// import 'package:flux/addmemebers.dart';
// import 'package:flux/application.dart';
// import 'package:flux/auth/otp_screen.dart';
// import 'package:flux/auth/phonenumber.dart';
// import 'package:flux/bankverification.dart';
// import 'package:flux/calling.dart';
// import 'package:flux/channelaudio.dart';
// import 'package:flux/channelchat.dart';
// import 'package:flux/channeldata.dart';
// import 'package:flux/channelfile.dart';
// import 'package:flux/channellist.dart';
// import 'package:flux/channeltabbar.dart';
// import 'package:flux/channels.dart';
// import 'package:flux/channelsearch.dart';
// import 'package:flux/chat.dart';
// import 'package:flux/chatpage.dart';
// import 'package:flux/chatprofile.dart';
// import 'package:flux/cleaning.dart';
// import 'package:flux/completedworks.dart';
// import 'package:flux/contest.dart';
// import 'package:flux/dashboard.dart';
// import 'package:flux/digitalmarketingworks.dart';
// import 'package:flux/drawer.dart';
// import 'package:flux/editchannel.dart';
// import 'package:flux/feedback.dart';
// import 'package:flux/fifthpage.dart';
// import 'package:flux/findtalent.dart';
// import 'package:flux/findwork.dart';
import 'package:flux/firebase_options.dart';
import 'package:flux/firstpage.dart';
import 'package:flux/flux.dart';
import 'package:flux/newchannel.dart';
import 'package:flux/payment.dart';
// import 'package:flux/new_page.dart';
import 'package:flux/sample.dart';
import 'package:flux/savedmessage.dart';
import 'package:flux/secondpage.dart';
import 'package:flux/service.dart';
import 'package:flux/settings.dart';
// import 'package:flux/logout.dart';
// import 'package:flux/mediafiles.dart';
// import 'package:flux/offline.dart';
// import 'package:flux/otppage.dart';
// import 'package:flux/graphicanddesign.dart';
// import 'package:flux/mychannels.dart';
// import 'package:flux/phoneauth.dart';
// import 'package:flux/profile.dart';
// import 'package:flux/newchannel.dart';
// import 'package:flux/notification.dart';
// import 'package:flux/panverification.dart';
// import 'package:flux/payment.dart';
// import 'package:flux/postacontest.dart';
// import 'package:flux/postatask.dart';
// import 'package:flux/postawork.dart';
// import 'package:flux/createprofile.dart';
// import 'package:flux/flux.dart';
// import 'package:flux/sample.dart';
// import 'package:flux/savedmessage.dart';
// import 'package:flux/service.dart';
// import 'package:flux/plumbing.dart';
// import 'package:flux/settings.dart';
// import 'package:flux/thirdpage.dart';
// import 'package:flux/verification.dart';
// import 'package:flux/videocall.dart';
// import 'package:flux/workexperience.dart';
// import 'package:flux/worknow.dart';
// import 'bussinesslogic/firebase_options.dart';
// import 'firstpage.dart';
// import 'secondpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flux',
      home: 
      FirebaseAuth.instance.currentUser != null
          ? bottomnavipage(initialIndex: 0)
          : page1(),
    );
  }
}
