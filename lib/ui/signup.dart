import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/services/apis/user_api.dart';
import 'package:viicsoft_inventory_app/ui/eventspage.dart';
import '../models/users.dart';
import 'homeview.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // TextEditingController holds values for the email and password fields
  AuthAPI _authApi = AuthAPI();
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  final TextEditingController _fullnameField = TextEditingController();
  Future<User>? _futureUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.blueAccent,
        ),
        child: Column(
          //MainAxisAlignment.spaceEvenly to evenly space padding between fields
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: _emailField,
                decoration: const InputDecoration(
                    hintText: "something@email.com",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 35),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: _passwordField,
                obscureText: true,
                decoration: const InputDecoration(
                    hintText: "password",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 35),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: _fullnameField,
                decoration: const InputDecoration(
                    hintText: "Tom Ford",
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    labelText: "Full Name",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 35),
            Container(
                width: MediaQuery.of(context).size.width / 1.4,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
                child: MaterialButton(
                  onPressed: () async {
                    try{
                      var req = await
                      _authApi.signUp (_emailField.text , _passwordField.text, _fullnameField.text);
                      if (req.statusCode == 200) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventsPage(),
                            ));
                      } else {
                        print(req.statusCode);
                      }
                    } on Exception catch (e){
                      print(e.toString());
                    }
                  },
                  child: const Text("Register"),
                )
            ),
          ],
        ),
      ),
    );
  }
}
