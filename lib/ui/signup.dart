// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class Signup extends StatefulWidget {
//   const Signup({Key? key}) : super(key: key);
//
//   @override
//   _SignupState createState() => _SignupState();
// }
//
// class _SignupState extends State<Signup> {
//   // TextEditingController holds values for the email and password fields
//   TextEditingController _emailField = TextEditingController();
//   TextEditingController _passwordField = TextEditingController();
//   TextEditingController _fullnameField = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: const BoxDecoration(
//           color: Colors.blueAccent,
//         ),
//         child: Column(
//           //MainAxisAlignment.spaceEvenly to evenly space padding between fields
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width / 1.3,
//               child: TextFormField(
//                 style: const TextStyle(color: Colors.white),
//                 controller: _emailField,
//                 decoration: const InputDecoration(
//                     hintText: "something@email.com",
//                     hintStyle: TextStyle(
//                       color: Colors.white,
//                     ),
//                     labelText: "Email",
//                     labelStyle: TextStyle(
//                       color: Colors.white,
//                     )),
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 35),
//             Container(
//               width: MediaQuery.of(context).size.width / 1.3,
//               child: TextFormField(
//                 style: const TextStyle(color: Colors.white),
//                 controller: _passwordField,
//                 obscureText: true,
//                 decoration: const InputDecoration(
//                     hintText: "password",
//                     hintStyle: TextStyle(
//                       color: Colors.white,
//                     ),
//                     labelText: "Password",
//                     labelStyle: TextStyle(
//                       color: Colors.white,
//                     )),
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 35),
//             Container(
//               width: MediaQuery.of(context).size.width / 1.3,
//               child: TextFormField(
//                 style: const TextStyle(color: Colors.white),
//                 controller: _fullnameField,
//                 decoration: const InputDecoration(
//                     hintText: "something@email.com",
//                     hintStyle: TextStyle(
//                       color: Colors.white,
//                     ),
//                     labelText: "Email",
//                     labelStyle: TextStyle(
//                       color: Colors.white,
//                     )),
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 35),
//             Container(
//                 width: MediaQuery.of(context).size.width / 1.4,
//                 height: 45,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15.0),
//                   color: Colors.white,
//                 ),
//                 child: MaterialButton(
//                   onPressed: () async {
//                     bool shouldNavigate =
//                     await register(_emailField.text, _passwordField.text);
//                     if (shouldNavigate) {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => HomeView(),
//                           ));
//                     }
//                   },
//                   child: const Text("Register"),
//                 )),
//             SizedBox(height: MediaQuery.of(context).size.height / 35),
//             Container(
//                 width: MediaQuery.of(context).size.width / 1.4,
//                 height: 45,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15.0),
//                   color: Colors.white,
//                 ),
//                 child: MaterialButton(
//                   onPressed: () async {
//                     bool shouldNavigate =
//                     await signIn(_emailField.text, _passwordField.text);
//                     if (shouldNavigate) {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => HomeView(),
//                           ));
//                     }
//                   },
//                   child: const Text("Login"),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
