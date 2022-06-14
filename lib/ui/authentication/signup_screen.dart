import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/component/buttom_navbar.dart';
import 'package:viicsoft_inventory_app/component/button.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/component/mytextform.dart';
import 'package:viicsoft_inventory_app/component/passwordcheck.dart';
import 'package:viicsoft_inventory_app/ui/authentication/login_screen.dart';
import '../../services/apis/auth_api.dart';

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
  String onChange = '';

  @override
  void dispose() {
    _fullNameField.dispose();
    _emailField.dispose();
    _passwordField.dispose();
    _confirmPasswordField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.white,
      key: _scaffoldKey,
      body: ListView(
        children: [
          Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(20.0, 50.0, 0.0, 0.0),
                      child: Text(
                        'Sign Up to continue',
                        style: TextStyle(
                          color: AppColor.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.015),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 30.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          MyTextForm(
                            controller: _fullNameField,
                            obscureText: false,
                            labelText: 'Enter your fullname',
                            validatior: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Full Name*';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screensize.height * 0.02),
                          MyTextForm(
                            controller: _emailField,
                            obscureText: false,
                            labelText: 'Enter your Email',
                            keyboardType: TextInputType.emailAddress,
                            validatior: (input) => !(input!.isNotEmpty &&
                                    input.contains('@') &&
                                    input.contains('.com'))
                                ? "You have entered a wrong email format"
                                : null,
                          ),
                          SizedBox(height: screensize.height * 0.02),
                          MyTextForm(
                              controller: _passwordField,
                              obscureText: _isObscurePassword,
                              labelText: 'Enter your password',
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscurePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: AppColor.textFormColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscurePassword = !_isObscurePassword;
                                    });
                                  }),
                              validatior: (value) {
                                bool passValid = RegExp(
                                        "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*?[!@#\$&*~]).*")
                                    .hasMatch(value!);
                                if (value.isEmpty || !passValid) {
                                  return 'Please enter Valid Pasword*';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  onChange = value;
                                });
                              }),
                          SizedBox(height: screensize.height * 0.01),
                          Container(
                            height: 135.0,
                            width: screensize.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(color: AppColor.textFormColor),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  PasswordCheck(
                                    isTextEmpty:
                                        onChange.isEmpty ? true : false,
                                    isContained: onChange
                                            .contains(RegExp("(?=.*[a-z]).*"))
                                        ? true
                                        : false,
                                    title:
                                        'Password must contain a small letter',
                                  ),
                                  PasswordCheck(
                                    isTextEmpty:
                                        onChange.isEmpty ? true : false,
                                    isContained: onChange
                                            .contains(RegExp("(?=.*[A-Z]).*"))
                                        ? true
                                        : false,
                                    title:
                                        'Password must contain a capital letter',
                                  ),
                                  PasswordCheck(
                                    isTextEmpty:
                                        onChange.isEmpty ? true : false,
                                    isContained: onChange
                                            .contains(RegExp("(?=.*[0-9]).*"))
                                        ? true
                                        : false,
                                    title:
                                        'Password must contain a number letter',
                                  ),
                                  PasswordCheck(
                                    isTextEmpty:
                                        onChange.isEmpty ? true : false,
                                    isContained: onChange.contains(
                                            RegExp("(?=.*?[!@#\$&*~]).*"))
                                        ? true
                                        : false,
                                    title:
                                        'Password must contain a symbol letter',
                                  ),
                                ]),
                          ),
                          SizedBox(height: screensize.height * 0.02),
                          MyTextForm(
                            controller: _confirmPasswordField,
                            obscureText: _isObscureConfirmPassword,
                            labelText: 'Confirm password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscureConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColor.textFormColor,
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    _isObscureConfirmPassword =
                                        !_isObscureConfirmPassword;
                                  },
                                );
                              },
                            ),
                            validatior: (value) {
                              if (_passwordField.text !=
                                  _confirmPasswordField.text) {
                                return 'The passwords do not match, pls verify*';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.055),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: MainButton(
                        backgroundColor: AppColor.primaryColor,
                        textColor: AppColor.buttonText,
                        borderColor: Colors.transparent,
                        text: 'SIGN UP',
                        onTap: () async {
                          if (_formkey.currentState!.validate()) {
                            var res = await _authAPI
                                .signUp(_fullNameField.text, _emailField.text,
                                    _passwordField.text)
                                .catchError(
                              (err) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        "${err.message} !",
                                        style: TextStyle(color: AppColor.red),
                                      ),
                                      content: const Text(
                                        'Check your network connection and try Again',
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: AppColor.red),
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
                              _formkey.currentState!.reset();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text("SignUp Successful")));
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const MyButtomNavigationBar()));
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Center(
                                      child: Text(
                                        "Error !",
                                        style: TextStyle(color: AppColor.red),
                                      ),
                                    ),
                                    content: const Text(
                                      'Email already in Use change email and try Again.',
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: AppColor.red),
                                        child: const Text("Ok"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.02),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Have an account already?',
                            style: TextStyle(
                              color: AppColor.black,
                              fontSize: 14.0,
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
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
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
