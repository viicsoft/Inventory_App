import 'dart:convert';
import 'package:viicsoft_inventory_app/models/users.dart';
import 'package:viicsoft_inventory_app/services/api.dart';
import 'package:http/http.dart' as http;
import '../sharedpref.dart';

class UserAPI extends BaseAPI {

 Future<List<User>> fetchAllUser () async {
    final String token = await SharedPrefrence().getToken();
    final response = await http
        .get(Uri.parse(super.allUsersPath),
        headers: {
          "X-Api-Key": "632F2EC9771B6C4C0BDF30BE21D9009B",
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'x-token': token,
        });
    if (response.statusCode == 200) {
      final  _data = jsonDecode(response.body);
      final List<User> users = _data['data']['user'].map<User>((model) => User.fromJson(model as Map<String, dynamic>)).toList();
      return users;
    } else {
      throw Exception('Failed to load Users');
    }
 }

 Future<http.Response> deleteUser(String id) async {
   final String token = await SharedPrefrence().getToken();

   var body = jsonEncode({'id': id});
   final http.Response response = await http.post(
     Uri.parse(super.deleteUserPath + id),
     headers: <String, String>{
       "X-Api-Key": "632F2EC9771B6C4C0BDF30BE21D9009B",
       "Content-Type": "application/json",
       'Accept': 'application/json',
       'x-token': token,
     },
     body: body
   );
   if (response.statusCode == 200) {
     //print(' delete user: ${response.body}');
     return response;
   } else {
     throw Exception('Failed to delete user.');
   }
 }




 Future<User> profileUser () async {
    final String token = await SharedPrefrence().getToken();
    final response = await http
        .get(Uri.parse(super.profileUserPath),
        headers: {
          "X-Api-Key": "632F2EC9771B6C4C0BDF30BE21D9009B",
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'x-token': token,
        });
    if (response.statusCode == 200) {
      final  _data = jsonDecode(response.body);
      final userResponse = new User.fromJson(_data['data']['user']);
      print(userResponse.fullName);
      return userResponse;
    } else {
      throw Exception('Failed to load Users');
    }
 }
}