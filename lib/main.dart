import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/ui/Menu/add_category.dart';
import 'package:viicsoft_inventory_app/ui/Menu/add_event_page.dart';
import 'package:viicsoft_inventory_app/ui/Menu/add_item_page.dart';
import 'package:viicsoft_inventory_app/ui/Menu/users/okwuytesting/userslist.dart';
import 'package:viicsoft_inventory_app/ui/Menu/users/passwordResetSuccessPage.dart';
import 'package:viicsoft_inventory_app/ui/Menu/users/reset_password_page.dart';
import 'package:viicsoft_inventory_app/ui/Menu/users/profileDetailsPage.dart';
import 'package:viicsoft_inventory_app/ui/authentication/loginScreen.dart';
import 'package:viicsoft_inventory_app/ui/authentication/loginsignupScreen.dart';
import 'package:viicsoft_inventory_app/ui/authentication/signupScreen.dart';
import 'package:viicsoft_inventory_app/ui/event/events_page.dart';
import 'package:viicsoft_inventory_app/ui/homePage.dart';


void main() async {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inventory App',
      initialRoute: '/',
  routes: {
    '/': (context) => const SignupLogin(),
    '/signup': (context) => const SignupPage(),
    '/login': (context) => const Login(),
    '/homePage': (context) => const HomePage(),
    '/UserList': (context) => const UserList(),
    '/userdetails': (context) => const UserDetailsPage(),
    '/addCategory': (context) => const AddCategory(),
    '/addItem': (context) => const AddItemPage(),
    '/addevent': (context) => const AddEventPage(),
    '/resetpassword': (context) => const ResetPasswordPage(),
    '/PasswordResetSuccessPage': (context) => const PasswordResetSuccessPage(),
    '/event': (context) => const EventsPage(),
  },
    );
  }
}