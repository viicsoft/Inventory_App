import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/models/users.dart';
import 'package:viicsoft_inventory_app/services/apis/user_api.dart';
// import 'package:flutter_auth_roleperm/helpers/sliderightroute.dart';
// import 'package:flutter_auth_roleperm/models/users.dart';
// import 'package:flutter_auth_roleperm/screens/edituserscreen.dart';
// import 'package:flutter_auth_roleperm/screens/usersscreen.dart';
// import 'package:flutter_auth_roleperm/services/api_service.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({Key? key, required this.users}) : super(key: key);
  final Users users;
  static const String _title = 'Users';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: StatefulUserDetailsWidget(users: users),
    );
  }
}

class StatefulUserDetailsWidget extends StatefulWidget {
  const StatefulUserDetailsWidget({Key? key, required this.users})
      : super(key: key);
  final Users users;

  @override
  // ignore: no_logic_in_create_state
  _UserDetailsWidgetState createState() => _UserDetailsWidgetState(users: users);
}

class _UserDetailsWidgetState extends State<StatefulUserDetailsWidget> {
  _UserDetailsWidgetState({required this.users});

   final Users users;
   final UserAPI api = UserAPI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 142, 54),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 26, 255, 1)),
        title: const Text(
          'User Details',
          style: TextStyle(
            height: 1.171875,
            fontSize: 18.0,
            fontFamily: 'Roboto Condensed',
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 26, 255, 1),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 26, 255, 1)),
          onPressed: () {} 
          // Navigator.pushReplacement(
          //     context, SlideRightRoute(page: const UsersScreen(errMsg: '',))
          // ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Card(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: const Color.fromARGB(255, 252, 142, 54),
                      border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  width: 440,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Name:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(widget.users.toString(),
                                style: Theme.of(context).textTheme.subtitle1)
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Email:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            // Text(widget.users.email.toString(),
                            //     style: Theme.of(context).textTheme.subtitle1)
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Phone:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            // Text(widget.users.phone.toString(),
                            //     style: Theme.of(context).textTheme.subtitle1)
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Role:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            // Text(widget.users.roles!.roleName.toString(),
                            //     style: Theme.of(context).textTheme.subtitle1)
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              child: SizedBox(
                                height: 60.0,
                                width: MediaQuery.of(context).size.width * 1.0,
                                child: ElevatedButton.icon(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    size: 24.0,
                                  ),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      side: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 128, 255, 0),
                                          width: 1.0),
                                    )),
                                    backgroundColor: MaterialStateProperty.all<
                                            Color>(
                                        const Color.fromARGB(255, 255, 200, 0)),
                                  ),
                                  onPressed: () async {
                                    // Navigator.pushReplacement(
                                    //     context,
                                    //     SlideRightRoute(
                                    //         page: EditUserScreen(
                                    //       users: users,
                                    //     )));
                                  },
                                  label: const Text('EDIT',
                                      style: TextStyle(
                                        height: 1.171875,
                                        fontSize: 24.0,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              child: SizedBox(
                                height: 60.0,
                                width: MediaQuery.of(context).size.width * 1.0,
                                child: ElevatedButton.icon(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    size: 24.0,
                                  ),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      side: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 128, 255, 0),
                                          width: 1.0),
                                    )),
                                    backgroundColor: MaterialStateProperty.all<
                                            Color>(
                                        const Color.fromARGB(255, 255, 200, 0)),
                                  ),
                                  onPressed: () async {
                                    _confirmDialog();
                                  },
                                  label: const Text('DELETE',
                                      style: TextStyle(
                                        height: 1.171875,
                                        fontSize: 24.0,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }

  Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure want delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Yes'),
              onPressed: () async {
                // var res = await api.deleteUser(widget.users.id.toString());

                // switch (res.statusCode) {
                //   case 200:
                //     // Navigator.pushReplacement(
                //     //     context, SlideRightRoute(page: const UsersScreen(errMsg: 'Deleted Successfully',)));
                //     break;
                //   case 400:
                //     var data = jsonDecode(res.body);
                //     if (data["msg"] != null) {
                //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //         content: Text(data["msg"].toString()),
                //       ));
                //     }
                //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //       content: Text("Delete Failed"),
                //     ));
                //     break;
                //   case 403:
                //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //       content: Text("Permission Denied"),
                //     ));
                //     break;
                //   default:
                //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //       content: Text("Delete Failed"),
                //     ));
                //     break;
                // }
              },
            ),
            ElevatedButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}