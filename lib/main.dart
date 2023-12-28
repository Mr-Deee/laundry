import 'package:flutter/material.dart';
import 'package:laundry/models/Client.dart';
import 'package:laundry/pages/Mainscreen.dart';
import 'package:laundry/pages/cleintdashboard.dart';

import 'package:laundry/pages/landingpage.dart';
import 'package:laundry/pages/laundryserviceDashboard.dart';
import 'package:laundry/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:laundry/pages/signup.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<Client>(
      create: (context) => Client(),
    ),
  ], child: MyApp()));
}

DatabaseReference clients = FirebaseDatabase.instance.ref().child("Clients");
DatabaseReference admin = FirebaseDatabase.instance.ref().child("Admin");
DatabaseReference request1 = FirebaseDatabase.instance.ref().child("Request");

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'HDP Laundry',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),

        initialRoute: FirebaseAuth.instance.currentUser == null
            ? '/landing'
            : '/main',
        routes: {

        "/main":(context) => Mainscreen(),
          "/dashboard": (context) => Dashboard(),
          "/LaundryService": (context) => LaundryService(),
          "/SignUP": (context) => signup(),
          "/login": (context) => Login(),
          "/landing": (context) => Landingpage(),
        });
  }
}
