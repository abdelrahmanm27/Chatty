// ignore_for_file: file_names

import 'package:flutter/material.dart';

void chattyNavigateTo(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}
