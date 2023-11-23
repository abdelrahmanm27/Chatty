// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_import

import 'package:chat_app/constants.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(Chatty());
}

class Chatty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: kPrimaryColor,
      debugShowCheckedModeBanner: false,
      title: 'Chatty',
      home: SplashScreen(),
    );
  }
}
