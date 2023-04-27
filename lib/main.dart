// ignore_for_file: prefer_const_constructors

// import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projectmockpage/helper/HelperFunction.dart';
import 'package:projectmockpage/pages/auth/loginPage.dart';
import 'package:projectmockpage/pages/auth/registerPage.dart';
import 'package:projectmockpage/pages/homePage.dart';
import 'package:projectmockpage/pages/profilePage.dart';
import 'package:projectmockpage/shared/constants.dart';
import 'shared/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSingedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSingedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Constant().primaryColor,
          scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: _isSingedIn ? const HomePage() : const LoginPage(),
      //home: HomePage(),
    );
  }
}
