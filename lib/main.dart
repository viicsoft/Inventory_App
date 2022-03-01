import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/ui/authentication/loginsignupScreen.dart';
import 'package:viicsoft_inventory_app/ui/eventspage.dart';
import 'package:viicsoft_inventory_app/ui/homeview.dart';
import 'package:viicsoft_inventory_app/ui/authentication/signupScreen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Inventory App',
      home: SignupLogin(),
    );
  }
}