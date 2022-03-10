import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/users.dart';
import '../../services/apis/user_api.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({Key? key}) : super(key: key);

  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  final UserAPI _userApi = UserAPI();
  late final List<AllUsers> usersList;
  late Future futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = _userApi.fetchAllUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("User Page"),
        ),
        body: Container(
            child: Center(
              child: FutureBuilder<List<User>>(
                  future: _userApi.fetchAllUser(),
                  builder: (BuildContext context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      final results = snapshot.data!;
                      return ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (ctx) =>
                                    //         DetailScreen(productModel: results[index]),
                                    //   ),
                                    // );
                                  },
                                  title: Text(
                                    results[index].email.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    // ignore: avoid_dynamic_calls
                                    results[index].fullName.toString(),
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  leading: Icon(
                                    Icons.circle,
                                    color: Colors.grey.shade900,
                                    size: 15,
                                  ),
                                ),
                                const Text(
                                  "...........................................................................................",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox();
                  }),
            ))
                );
  }
}
