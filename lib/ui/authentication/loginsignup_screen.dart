import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/component/button.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/ui/authentication/login_screen.dart';
import 'package:viicsoft_inventory_app/ui/authentication/signup_screen.dart';

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
      backgroundColor: AppColor.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: Container()),
          SizedBox(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: screensize.height * 0.5,
                        width: screensize.width,
                        decoration: BoxDecoration(
                          color: AppColor.primaryColorDark,
                          borderRadius: const BorderRadius.all(
                              Radius.elliptical(250, 200)),
                        ),
                        child: Center(
                          child: Image.asset('assets/Logo.png',
                              width: 195, height: 63),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screensize.height * 0.12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: MainButton(
              text: 'SIGN IN',
              backgroundColor: AppColor.white,
              textColor: AppColor.black,
              borderColor: AppColor.primaryColor,
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Login())),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: MainButton(
              text: 'SIGN UP',
              backgroundColor: AppColor.primaryColor,
              textColor: AppColor.buttonText,
              borderColor: AppColor.white,
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignupPage())),
            ),
          ),
          const SizedBox(
            height: 57.5,
          )
        ],
      ),
    );
  }
}
