// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable

import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class ChattyBubble extends StatelessWidget {
  String userMessage;
  String userEmail;
  ChattyBubble({
    required this.userMessage,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        margin: EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                userEmail,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                userMessage,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),            
            ],
          ),
        ),
      ),
    );
  }
}

class ChattyBubbleForFriend extends StatelessWidget {
  String userMessage;
  String userEmail;
  ChattyBubbleForFriend({
    required this.userMessage,
    required this.userEmail,   
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff006d84),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        margin: EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                userEmail,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                userMessage,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),             
            ],
          ),
        ),
      ),
    );
  }
}
