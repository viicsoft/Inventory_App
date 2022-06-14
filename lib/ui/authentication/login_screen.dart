import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/component/buttom_navbar.dart';
import 'package:viicsoft_inventory_app/component/button.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/component/mytextform.dart';
import 'package:viicsoft_inventory_app/services/apis/auth_api.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

TextEditingController _emailField = TextEditingController();
TextEditingController _passwordField = TextEditingController();

class _LoginState extends State<Login> {
  //Data requestModel = Data(email: 'input', pass: 'input');
  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Form(
                key: _globalFormKey,
                child: Column(
                  children: [
                    Container(
                      width: screensize.width,
                      color: AppColor.primaryColor,
                      height: screensize.height / 2.5,
                      child: Center(
                          child: Image.asset(
                        'assets/Logo.png',
                        color: AppColor.darkGrey,
                        width: 195,
                        height: 69,
                      )),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sign In to continue',
                                style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 25.5,
                              ),
                              MyTextForm(
                                obscureText: false,
                                labelText: 'Enter your email',
                                controller: _emailField,
                                validatior: (input) =>
                                    !(input?.contains('@') ?? false)
                                        ? "Please enter valid Email"
                                        : null,
                              ),
                              SizedBox(height: screensize.height * 0.02),
                              MyTextForm(
                                obscureText: _isObscure,
                                controller: _passwordField,
                                labelText: 'Enter your password',
                                validatior: (input) => (input != null &&
                                        input.length < 6)
                                    ? "Password should be more than 5 characters"
                                    : null,
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      _isObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: AppColor.textFormColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    }),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: screensize.height * 0.085),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: MainButton(
                                text: 'SIGN IN',
                                backgroundColor: AppColor.primaryColor,
                                textColor: AppColor.buttonText,
                                borderColor: Colors.transparent,
                                onTap: () async {
                                  if (_globalFormKey.currentState!.validate()) {
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
                                                    color: AppColor.red),
                                              ),
                                              content: const Text(
                                                'Wrong Email or Password',
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              AppColor.red),
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
                                              const MyButtomNavigationBar(),
                                          //BottomNavigationBarPage(),
                                        ),
                                      );
                                    }
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'New User?',
                              style: TextStyle(
                                color: AppColor.black,
                                fontSize: 14.0,
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            InkWell(
                              onTap: () async {
                                Navigator.pushNamed(context, '/signup');
                              },
                              child: Text(
                                'Sign Up Here',
                                style: TextStyle(
                                  color: AppColor.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
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
