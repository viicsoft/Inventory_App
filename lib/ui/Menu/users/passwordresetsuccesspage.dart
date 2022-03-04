import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';

class PasswordResetSuccessPage extends StatefulWidget {
  const PasswordResetSuccessPage({Key? key}) : super(key: key);

  @override
  State<PasswordResetSuccessPage> createState() => _PasswordResetSuccessPageState();
}

class _PasswordResetSuccessPageState extends State<PasswordResetSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.check,
                  size: 150.0,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(child: Container()),
            Text(
              'Password Reset\n Successfully !',
              style: TextStyle(
                fontSize: 30,
                color: AppColor.homePageTitle,
                fontWeight: FontWeight.w400,
              ),
            ),
            Expanded(flex: 2, child: Container()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Continue'),
                  style: ElevatedButton.styleFrom(primary: AppColor.gradientFirst),
                ),
              ],
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
