import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
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
    var screensize = MediaQuery.of(context).size;
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
                    Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            child: Text(
                              'CRISP TV',
                              style: TextStyle(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent),
                            ),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            child: Icon(
                              Icons.photo_camera_front,
                              size: 45,
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screensize.height * 0.1,
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
                            validator: (input) =>
                                !(input?.contains('@') ?? false)
                                    ? "Please enter valid Email"
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

                          SizedBox(height: screensize.height * 0.05),
                          TextFormField(
                            obscureText: _isObscure,
                            keyboardType: TextInputType.text,
                            controller: _passwordField,
                            validator: (input) => (input != null &&
                                    input.length < 6)
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
                          // const SizedBox(height: 6.0),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     Container(
                          //       padding: const EdgeInsets.only(
                          //           top: 15.0, left: 200.0),
                          //       child: const InkWell(
                          //         child: Text(
                          //           'Forgot Password',
                          //           style: TextStyle(
                          //               color: Colors.red,
                          //               fontWeight: FontWeight.bold,
                          //               decoration: TextDecoration.underline),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          SizedBox(height: screensize.height * 0.18),
                          SizedBox(
                            height: 50.0,
                            child: InkWell(
                              onTap: () async {
                                if (globalFormKey.currentState!.validate()) {
                                  var res = await _authAPI
                                      .login(_emailField.text.trim(),
                                          _passwordField.text.trim())
                                      .catchError(
                                    (err) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              "${err.message} !",
                                              style: TextStyle(
                                                  color:
                                                      AppColor.gradientFirst),
                                            ),
                                            content: const Text(
                                              'Wrong Email or Password',
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary:
                                                        AppColor.gradientFirst),
                                                child: const Text("Ok"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  );

                                  if (res.statusCode == 200) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const BottomNavigationBarPage()));
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
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: screensize.height * 0.02),
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
