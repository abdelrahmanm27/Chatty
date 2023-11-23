// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

class ChattyTextFormField extends StatelessWidget {
  String? hintText;
  String? labelText;
  bool isPassword;
  TextInputType? keyboardType;
  Function(String val)? onChanged;
  ChattyTextFormField({
    required this.hintText,
    required this.labelText,
    this.isPassword = false,
    this.onChanged,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: TextFormField(
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: (val) {
          if (val!.isEmpty) {
            return 'This field is required!';
          }
          return null;
        },
        obscureText: isPassword,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          focusColor: Colors.white,
          hintText: hintText!,
          label: Text(
            labelText!,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
