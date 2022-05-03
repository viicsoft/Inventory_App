import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/ui/authentication/loginScreen.dart';
import 'package:viicsoft_inventory_app/ui/bottom_navigationbar.dart';
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

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
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
                      padding: const EdgeInsets.fromLTRB(15.0, 70.0, 0.0, 0.0),
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0,
                        ),
                      ),
                    ),
                    SizedBox(height: screensize.height * 0.03),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 30.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _fullNameField,
                            cursorColor: Colors.black54,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColor.gradientFirst,
                                ),
                              ),
                              labelText: 'Full Name',
                              labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Full Name*';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screensize.height * 0.03),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailField,
                            cursorColor: Colors.black54,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColor.gradientFirst,
                                ),
                              ),
                              labelText: 'Email',
                              labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            validator: (input) =>
                                !(input!.isNotEmpty && input.contains('@'))
                                    ? "Please enter valid Email"
                                    : null,
                          ),
                          SizedBox(height: screensize.height * 0.03),
                          TextFormField(
                            obscureText: _isObscurePassword,
                            controller: _passwordField,
                            cursorColor: Colors.black54,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColor.gradientFirst,
                                ),
                              ),
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscurePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscurePassword = !_isObscurePassword;
                                    });
                                  }),
                              hintText:
                                  'password must contain Upper case and lowercase',
                              hintStyle: const TextStyle(
                                  fontSize: 12, color: Colors.red),
                              labelText: 'Pasword',
                              labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            validator: (value) {
                              bool passValid =
                                  RegExp("^(?=.*[A-Z])(?=.*[a-z]).*")
                                      .hasMatch(value!);
                              if (value.isEmpty || !passValid) {
                                return 'Please enter Valid Pasword*';
                              }
                              if (value.length < 6) {
                                return 'Pasword Must be more than 5 charater*';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screensize.height * 0.03),
                          TextFormField(
                            obscureText: _isObscureConfirmPassword,
                            controller: _confirmPasswordField,
                            cursorColor: Colors.black54,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColor.gradientFirst,
                                ),
                              ),
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscureConfirmPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscureConfirmPassword =
                                          !_isObscureConfirmPassword;
                                    });
                                  }),
                              labelText: 'Confirm Pasword',
                              labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (_passwordField.text !=
                                  _confirmPasswordField.text) {
                                return 'Please Confirm Pasword*';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: screensize.height * 0.13),
                          InkWell(
                            onTap: () async {
                              if (_formkey.currentState!.validate()) {
                                var res = await _authAPI
                                    .signUp(_fullNameField.text,
                                        _emailField.text, _passwordField.text)
                                    .catchError(
                                  (err) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            "${err.message} !",
                                            style: TextStyle(
                                                color: AppColor.gradientFirst),
                                          ),
                                          content: const Text(
                                            'Check your network connection and try Again',
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
                                  _formkey.currentState!.reset();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text("SignUp Successful")));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const BottomNavigationBarPage()));
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Center(
                                          child: Text(
                                            "Error !",
                                            style: TextStyle(
                                                color: AppColor.gradientFirst),
                                          ),
                                        ),
                                        content: const Text(
                                          'Email already in Use change email and try Again.',
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
                          SizedBox(height: screensize.height * 0.02),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
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
                            ),
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
