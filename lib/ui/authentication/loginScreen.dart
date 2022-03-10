import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/models/users.dart';
import 'package:viicsoft_inventory_app/services/apis/auth_api.dart';
import 'package:viicsoft_inventory_app/ui/bottom_navigationbar.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

TextEditingController _emailField = TextEditingController();
TextEditingController _passwordField = TextEditingController();

class _LoginState extends State<Login> {

  //Data requestModel = Data(email: 'input', pass: 'input');
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isLoading = false;
  final AuthAPI _authAPI = AuthAPI();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Form(
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
                          //onSaved: (input) => requestModel.email = input!,
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
                          ),
                        ),


                        const SizedBox(height: 20.0),
                        TextFormField(
                          obscureText: _isObscure,
                          keyboardType: TextInputType.text,
                          controller: _passwordField,
                          //onSaved: (input) => requestModel.pass = input!,
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
                        SizedBox(
                          height: 50.0,
                          child: InkWell(
                            onTap: () async {
                      if (globalFormKey.currentState!.validate()) {
                        var res = await _authAPI.login(
                            _emailField.text.trim(), _passwordField.text.trim());

                            if (res.statusCode == 200) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(elevation: 4,
                                      backgroundColor: Colors.green,
                                        content:
                                            Text("login Successful", textAlign: TextAlign.center)));
                                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (_)=>const BottomNavigationBarPage()));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.red,
                                    content:
                                        Text("Login failed, Wrong email or password !", textAlign: TextAlign.center),
                                  ),
                                );
                              }
                             } 
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
                        //),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  )
                ],
              ),
              ),
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
                      Navigator.pushNamed(context, '/signup');
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
