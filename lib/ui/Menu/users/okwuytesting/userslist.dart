import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/models/users.dart';
import 'package:viicsoft_inventory_app/ui/Menu/users/okwuytesting/usedetail.dart';
import 'package:viicsoft_inventory_app/ui/Menu/users/userDetailsPage.dart';

class UserListWidget extends StatelessWidget {
  final List<Users> users;

  const UserListWidget({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.isEmpty ? 0 : users.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          child: Card(
            color: const Color.fromARGB(255, 252, 142, 54),
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                  color: Color.fromARGB(255, 0, 0, 0), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          UserDetailsScreen(users: users[index])),
                );
              },
              child: const ListTile(
                leading: Icon(
                  Icons.person,
                  size: 48,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                title: Text(
                  "",
                  //[index].fullname.toString(),
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                subtitle: Text("",
                  //users[index].email.toString(),
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}