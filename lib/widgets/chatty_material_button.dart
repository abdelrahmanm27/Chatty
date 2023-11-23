// ignore_for_file: avoid_unnecessary_containers, must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors

import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class ChattyMaterialButton extends StatelessWidget {
  VoidCallback onPressed;
  String buttonText;

  ChattyMaterialButton({required this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: MaterialButton(
          minWidth: double.infinity,
          height: 40,
          onPressed: onPressed,
          textColor: kPrimaryColor,
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 20,),
          ),
        ),
      ),
    );
  }
}
