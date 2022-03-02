import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/ui/authentication/loginScreen.dart';

import '../../services/apis/user_api.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final AuthAPI _authAPI = AuthAPI();
  final _key = GlobalKey<FormState>();
  final TextEditingController _fullNameField = TextEditingController();
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(15.0, 80.0, 0.0, 0.0),
                        child: const Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 35.0,
                          ),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
                          child: Column(
                            children: <Widget>[
                             TextFormField(
                               controller: _fullNameField,
                                decoration: const InputDecoration(
                                  labelText: 'Full Name',
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              TextFormField(
                                controller: _emailField,
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              TextFormField(
                                controller: _passwordField,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                  ),
                                ),
                              ),
                              
                              const SizedBox(height: 100.0),
                              Container(
                                height: 50.0,
                                child: Material(
                                  borderRadius: BorderRadius.circular(40.0),
                                  shadowColor: Colors.redAccent,
                                  color: Colors.red,
                                  elevation: 7.0,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: const Center(
                                      child: Text(
                                        'SIGNUP',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 50.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text(
                                    'Already have an account?',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 5.0),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push (
                                        context,
                                        MaterialPageRoute (
                                          builder: (BuildContext context) => const Login(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                      ),
                    ],
                  ),
                ),
              ],
          ),
        ],
      ),
    );
  }
}
