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
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _fullNameField = TextEditingController();
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  final TextEditingController _confirmPasswordField = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool _isObscurePassword = true;
  bool _isObscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: [
          Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[


                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(15.0, 70.0, 0.0, 0.0),
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
                      padding: const EdgeInsets.only(
                          top: 30.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[


                          TextFormField(
                            controller: _fullNameField,
                            decoration: const InputDecoration(
                              labelText: 'Full Name',
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Full Name*';
                              }
                              return null;
                            },
                          ),


                          const SizedBox(height: 10.0),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailField,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Email*';
                              }
                              return null;
                            },
                          ),


                          const SizedBox(height: 10.0),
                          TextFormField(
                            obscureText: _isObscurePassword,
                            controller: _passwordField,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(_isObscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isObscurePassword = !_isObscurePassword;
                                    });
                                  }),
                              labelText: 'Pasword',
                              labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Pasword*';
                              }
                              if (value.length < 6) {
                                return 'Pasword Must be more than 5 charater*';
                              }
                              return null;
                            },
                          ),



                          const SizedBox(height: 10.0),
                          TextFormField(
                            obscureText: _isObscureConfirmPassword,
                            controller: _confirmPasswordField,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(_isObscureConfirmPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isObscureConfirmPassword = !_isObscureConfirmPassword;
                                    });
                                  }),
                              labelText: 'Confirm Pasword',
                              labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            validator: (value) {
                              if (_passwordField.text !=
                                      _confirmPasswordField.text) {
                                return 'Please Confirm Pasword*';
                              }
                              return null;
                            },
                          ),

                          

                          const SizedBox(height: 80.0),
                          InkWell(
                            onTap: () async {
                              if (_formkey.currentState!.validate()
                                  ) {
                                var res = await _authAPI.signUp(
                                    _fullNameField.text,
                                    _emailField.text,
                                    _passwordField.text);
                                if (res.statusCode == 200) {
                                  setState(() {});
                                  _formkey.currentState!.reset();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.green,
                                          content:
                                              Text("SignUp Successful")));
                                              Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (_)=>const Login()));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.red,
                                      content:
                                          Text("Wrong email or password !"),
                                    ),
                                  );
                                }
                              }
                            },
                            child: SizedBox(
                              height: 50.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(40.0),
                                shadowColor: Colors.redAccent,
                                color: Colors.red,
                                elevation: 7.0,
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



                          const SizedBox(height: 50.0),
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const Login(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Login',
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
