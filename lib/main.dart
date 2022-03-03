import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:viicsoft_inventory_app/ui/authentication/loginScreen.dart';
=======
import 'package:viicsoft_inventory_app/models/events.dart';
>>>>>>> 97ba0ff44978d23ee05e63ae2bdfcac92dbdd91b
import 'package:viicsoft_inventory_app/ui/authentication/loginsignupScreen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:viicsoft_inventory_app/ui/eventspage.dart';
void main() async {
  runApp( const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return  MaterialApp(
      title: 'Inventory App',
      //home: SignupLogin(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SignupLogin(),
        '/login':(context) => const Login()
      },
=======
    return MaterialApp(
      title: 'Inventory App',
      home: EventsPage(),
>>>>>>> 97ba0ff44978d23ee05e63ae2bdfcac92dbdd91b
    );
  }
}