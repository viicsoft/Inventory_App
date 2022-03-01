import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/models/users.dart';
import 'package:viicsoft_inventory_app/ui/authentication/signupScreen.dart';
import 'package:viicsoft_inventory_app/ui/homeview.dart';

import '../../services/apis/user_api.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthAPI _authAPI = AuthAPI();
  final _key = GlobalKey<FormState>();
  late String email;
  late String password;
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                          child: const Text(
                            'CRISP TV',
                            style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(
                              10.0, 120.0, 10.0, 10.0),
                          child: const Icon(
                            Icons.photo_camera_front,
                            size: 45,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 50, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _emailField,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          TextFormField(
                            controller: _passwordField,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          Container(
                            padding:
                                const EdgeInsets.only(top: 15.0, left: 200.0),
                            child: const InkWell(
                              child: Text(
                                'Forgot Password',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                          const SizedBox(height: 100.0),
                          Container(
                            height: 50.0,
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (_) =>
                                //             const BottomNavigationBarPage()));
                              },
                              child: Material(
                                borderRadius: BorderRadius.circular(40.0),
                                shadowColor: Colors.redAccent,
                                color: Colors.red,
                                elevation: 7.0,
                                child: const Center(
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              //Expanded(flex: 2,
              // child: Container()),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'New to Crisp Tv?',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  InkWell(
                    onTap: () async {
                      try {
                        var req = await _authAPI.login(
                            _emailField.text, _passwordField.text);
                        if (req.statusCode == 200) {
                          print(req.body);
                        } else {
                          print("error");
                        }
                      } on Exception catch (e) {
                        print(e.toString());
                      }
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
