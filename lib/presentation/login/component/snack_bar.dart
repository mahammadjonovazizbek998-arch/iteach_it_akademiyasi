import 'package:flutter/material.dart';

void showiDalog(String error,BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(error),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
    ),
  );
}