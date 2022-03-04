import 'package:flutter/material.dart';

Widget textform(
      {String? label,
      IconData? icon,
      Widget? suffixIcon,
      String? initialValue,
      bool obscureText = false}) {
    return TextFormField(
      initialValue: initialValue,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        icon: Icon(
          icon,
          color: Colors.grey,
        ),
        labelText: label,
      ),
    );
  }