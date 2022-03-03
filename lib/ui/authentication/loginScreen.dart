import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:viicsoft_inventory_app/models/users.dart';
//import 'package:viicsoft_inventory_app/ui/authentication/signupScreen.dart';
//import 'package:viicsoft_inventory_app/ui/homeview.dart';
//import '../../services/apis/user_api.dart';

import 'package:viicsoft_inventory_app/models/users.dart';
import 'package:viicsoft_inventory_app/services/apis/user_api.dart';
import 'package:viicsoft_inventory_app/ui/authentication/loginsignupScreen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

TextEditingController _emailField = TextEditingController();
TextEditingController _passwordField = TextEditingController();

class _LoginState extends State<Login> {

  Data requestModel = Data(email: 'input', pass: 'input');
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isLoading = false;
  final AuthAPI _authAPI = AuthAPI();
  final _key = GlobalKey<FormState>();
  bool _isObscure = true;

  

  // @override
  // void initState(){
  //   super.initState();
  //   requestModel = Data(email: 'input', pass: 'input');
  //   // setState(() {
  //   //   _emailField = TextEditingController();
  //   //   _passwordField = TextEditingController();
  //   // });
  // }
  

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
                child: Form(
                  key: globalFormKey,
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
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailField,
                            onSaved: (input) => requestModel.email = input!,
                            validator: (input) => !(input?.contains('@') ?? false)
                            ? "Email id should be valid"
                            : null,
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.redAccent,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                              ),
                              // labelStyle: TextStyle(
                              //     fontWeight: FontWeight.bold,
                              //     color: Colors.grey),
                            ),
                          ),


                          const SizedBox(height: 20.0),
                          TextFormField(
                            obscureText: _isObscure,
                            keyboardType: TextInputType.text,
                            controller: _passwordField,
                            onSaved: (input) => requestModel.pass = input!,
                            validator: (input) => (input != null && input.length < 6)
                            ? "Password should be more than 5 characters"
                            : null,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(_isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  }),
                              hintText: 'Password',
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.redAccent,
                                ),
                              ),
                              prefixIcon: const Icon(
                                  Icons.lock_outline_rounded,
                              ),
                              // labelStyle: TextStyle(
                              //     fontWeight: FontWeight.bold,
                              //     color: Colors.grey),
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
                            child: InkWell(
                              onTap: () async {
                                // if(globalFormKey.currentState!.validate()) {
                                //   globalFormKey.currentState!.save();
                                //   print(requestModel.toJson());
                                // }

                        //         if(globalFormKey.currentState==null) {
                        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        //   content: Text("Wrong email and password!"),
                        // ));
                      //} else {
                        if (globalFormKey.currentState!.validate()) {
                          var res = await _authAPI.login(
                              _emailField.text.trim(), _passwordField.text.trim());

                              if (res.statusCode == 200) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.green,
                                          content:
                                              Text("login Successful")));
                                              Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (_)=>const Login()));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.red,
                                      content:
                                          Text("Login failed, Wrong email or password !"),
                                    ),
                                  );
                                }
                               } 
                      

                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (_) =>
                                //             const BottomNavigationBarPage()));
                              },
                              // child: InkWell(
                              //   onTap: (){
                              //     if(_emailField.text.isEmpty||_passwordField.text.isEmpty)
                              //     {
                              //       print('Enter email and password');
                              //     }
                              //     _authAPI.login(_emailField.text,_passwordField.text);
                                  
                              //   },
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
                          //),
                          const SizedBox(height: 20.0),
                        ],
                      ),
                    )
                  ],
                ),
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
                      // try {
                      //   var req = await _authAPI.login(
                      //       _emailField.text, _passwordField.text);
                      //   if (req.statusCode == 200) {
                      //     print(req.body);
                      //   } else {
                      //     print("error");
                      //   }
                      // } on Exception catch (e) {
                      //   print(e.toString());
                      // }
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

  // bool validateAndSave(){
  //   final form = globalFormKey.currentState;
  //   //if(form?.validate()){
  //     return true;
  //  // }
  //   //return false;
  // }
}
