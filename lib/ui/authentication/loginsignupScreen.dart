import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/ui/authentication/loginScreen.dart';
import 'package:viicsoft_inventory_app/ui/authentication/signupScreen.dart';

class SignupLogin extends StatefulWidget {
  const SignupLogin({Key? key}) : super(key: key);

  @override
  _SignupLoginState createState() => _SignupLoginState();
}

class _SignupLoginState extends State<SignupLogin> {
  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: Container()),
          SizedBox(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                    child: const Text(
                      'WELCOME TO',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        child: Text(
                          'CRISPTV',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      SizedBox(
                        child: Icon(
                          Icons.photo_camera_front,
                          size: 45,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ],
                  ),
                  //SizedBox(height: 100.0),
                  //Container(
                  // ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screensize.height * 0.4,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignupPage()));
            },
            child: Container(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              height: 50.0,
              child: Material(
                borderRadius: BorderRadius.circular(40.0),
                shadowColor: Colors.redAccent,
                color: Colors.red,
                elevation: 7.0,
                child: const Center(
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 90),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  height: 50.0,
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
            ],
          ),
          Expanded(flex: 2, child: Container()),
        ],
      ),
    );
  }
}
