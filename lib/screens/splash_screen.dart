// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors

import 'dart:async';

import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {    
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              appLogo,
              width: 90,
              height: 90,
            ),
            Text(
              'Chatty',
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),           
            Text(
              'By: Dev Abdelrahman',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
