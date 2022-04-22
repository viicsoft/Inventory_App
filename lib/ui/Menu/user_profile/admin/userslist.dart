import 'package:flutter/material.dart';
import 'package:viicsoft_inventory_app/component/colors.dart';
import 'package:viicsoft_inventory_app/models/users.dart';
import 'package:viicsoft_inventory_app/services/apis/user_api.dart';
import 'package:viicsoft_inventory_app/ui/Menu/user_profile/admin/usedetail.dart';

class UserList extends StatefulWidget {
  //final List<Users> users;

  const UserList({
    Key? key,
  }) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 50, right: 10, left: 10),
        child: FutureBuilder<List<User>>(
          future: UserAPI().fetchAllUser(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: CircularProgressIndicator(color: AppColor.gradientFirst),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              var results = snapshot.data!;
              return Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(top: 20, right: 10, left: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColor.gradientFirst,
                          AppColor.gradientSecond,
                        ],
                        begin: const FractionalOffset(0.0, 0.4),
                        end: Alignment.topRight,
                      ),
                      color: AppColor.homePageContainerTextBig,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(2, 5),
                          blurRadius: 4,
                          color: AppColor.gradientSecond.withOpacity(0.2),
                        )
                      ],
                    ),
                    child: Column(children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              size: 25,
                              color: AppColor.homePageContainerTextBig,
                            ),
                          ),
                          Expanded(child: Container()),
                          Text(
                            'Registered Users',
                            style: TextStyle(
                              fontSize: 22,
                              color: AppColor.homePageContainerTextBig,
                            ),
                          ),
                          Expanded(flex: 2, child: Container()),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.all(5),
                              height: 25,
                              child: Center(
                                child: Text(
                                  results.length.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              ' Total Users',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColor.homePageContainerTextBig),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount:
                        results.length, //users.isEmpty ? 0 : users.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        margin: const EdgeInsets.only(
                            bottom: 15, right: 5, left: 5),
                        elevation: 2,
                        color: AppColor.homePageContainerTextBig,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserDetailsScreen(
                                      userdetail: results[index])),
                            );
                          },
                          child: ListTile(
                            trailing: IconButton(
                                onPressed: () async {
                                  await _confirmDialog(
                                      context,
                                      results[index].id.toString(),
                                      results[index].fullName);
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: AppColor.gradientFirst,
                                )),
                            leading: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      results[index].avatarThumbnail),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(
                              results[index].fullName,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: AppColor.homePageSubtitle),
                            ),
                            subtitle: Text(
                              results[index].email,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: AppColor.gradientFirst,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(color: AppColor.gradientFirst),
              );
            }
          },
        ),
      ),
    );
  }

  Future _confirmDialog(
      BuildContext context, String userId, String userName) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want delete $userName ?'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: AppColor.gradientFirst),
              child: const Text('Yes'),
              onPressed: () async {
                var res = await UserAPI().deleteUser(userId);
                if (res.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("$userName successfully deleted")));
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Are you sure want to delete $userName?'),
                    ),
                  );
                }
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: AppColor.gradientFirst),
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
