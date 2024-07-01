import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flux/admin/dashboard.dart';
import 'package:flux/data/helperprovider.dart';
import 'package:flux/data/payment_controller.dart';
import 'package:flux/firebase_options.dart';
import 'package:flux/firstpage.dart';
import 'package:flux/flux.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PaymentController>(
            create: (_) => PaymentController()),
        ChangeNotifierProvider(
          create: (context) => HelperProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flux',
        initialRoute:
            FirebaseAuth.instance.currentUser != null ? '/home' : '/login',
        // routes: {
        //   '/login': (context) => page1(),
        //   '/home': (context) => bottomnavipage(initialIndex: 0),
        // },
        home: 
        // FirebaseAuth.instance.currentUser != null
        //     ? bottomnavipage(initialIndex: 0)
        //     : 
            AdminDashboard(),
      ),
    );
  }
}
