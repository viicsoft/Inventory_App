import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:viicsoft_inventory_app/models/users.dart';
import 'package:viicsoft_inventory_app/services/api.dart';

class UserAPI extends BaseAPI {

  // Future<List<Users>> fetchAllUsers() async {

  //   final response = await http
  //       .get(Uri.parse(super.allUsersPath), headers: super.headers);

  //   if (response.statusCode == 200) {
  //     final  _data = jsonDecode(response.body);
  //     final List<Users> users = _data['data']['data'].map<Users>((model) => Users.fromJson(model as Map<String, dynamic>)).toList();
  //     print(response.body);
  //     return users;
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load Events');

  //   }
  // }
   Future<http.Response> getUserList() async {
    final res = await http
        .get(Uri.parse(super.allUsersPath), headers: super.headers);
    print(res.body);
    return res;
  }

}