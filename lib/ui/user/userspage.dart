// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:viicsoft_inventory_app/models/auth.dart';

// import '../../services/apis/user_api.dart';

// class allUsers extends StatefulWidget {
//   const allUsers({Key? key}) : super(key: key);

//   @override
//   _allUsersState createState() => _allUsersState();
// }

// class _allUsersState extends State<allUsers> {
//   final UserAPI _userApi = UserAPI();
//   late final List<allUsers> usersList;
//   late Future futureUser;

//   @override
//   void initState() {
//     super.initState();
//     futureUser = _userApi.fetchAllUsers();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // appBar: AppBar(
//         //   // Here we take the value from the MyHomePage object that was created by
//         //   // the App.build method, and use it to set our appbar title.
//         //   title: Text("User Page"),
//         // ),
//         // body: Container(
//         //     child: Center(
//         //       child: FutureBuilder<List>(
//         //           future: UserApi().fetchAllUsers(),
//         //           builder: (BuildContext context, snapshot) {
//         //             if (!snapshot.hasData) {
//         //               return Container(
//         //                 child: Center(
//         //                   child: CircularProgressIndicator(),
//         //                 ),
//         //               );
//         //             }
//         //             if (snapshot.connectionState == ConnectionState.done) {
//         //               final results = snapshot.data!;
//         //               return ListView.builder(
//         //                 itemCount: results.length,
//         //                 itemBuilder: (BuildContext context, int index) {
//         //                   return Padding(
//         //                     padding: const EdgeInsets.all(8.0),
//         //                     child: Column(
//         //                       children: [
//         //                         ListTile(
//         //                           onTap: () {
//         //                             // Navigator.push(
//         //                             //   context,
//         //                             //   MaterialPageRoute(
//         //                             //     builder: (ctx) =>
//         //                             //         DetailScreen(productModel: results[index]),
//         //                             //   ),
//         //                             // );
//         //                           },
//         //                           title: Text(
//         //                             // ignore: avoid_dynamic_calls
//         //                             results[index].data.pass.toString(),
//         //                             style: const TextStyle(color: Colors.white),
//         //                           ),
//         //                           subtitle: Text(
//         //                             // ignore: avoid_dynamic_calls
//         //                             results[index].data.email.toString(),
//         //                             style: TextStyle(color: Colors.black87),
//         //                           ),
//         //                           leading: Icon(
//         //                             Icons.circle,
//         //                             color: Colors.grey.shade900,
//         //                             size: 15,
//         //                           ),
//         //                         ),
//         //                         const Text(
//         //                           "...........................................................................................",
//         //                           style: TextStyle(color: Colors.white),
//         //                         )
//         //                       ],
//         //                     ),
//         //                   );
//         //                 },
//         //               );
//         //             }
//         //             return const SizedBox();
//         //           }),
//         //     ))
//                 );
//   }
// }
