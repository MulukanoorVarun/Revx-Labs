import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white, fontFamily: "Poppins",fontSize: 14 ),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xff27bdbe),
      ),
    );
  }
}