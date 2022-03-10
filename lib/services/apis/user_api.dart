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

 Future<User> deleteUser(String id) async {
   final String token = await SharedPrefrence().getToken();

   final http.Response response = await http.delete(
     Uri.parse(super.deleteUserPath + id),
     headers: <String, String>{
       "X-Api-Key": "632F2EC9771B6C4C0BDF30BE21D9009B",
       "Content-Type": "application/json",
       'Accept': 'application/json',
       'x-token': token,
     },
   );
   if (response.statusCode == 200) {
     return User.fromJson(jsonDecode(response.body));
   } else {
     throw Exception('Failed to delete user.');
   }
 }


//  Future<List<Profile>> fetchUser() async {
//     final String token = await SharedPrefrence().getToken();
//     final response = await client.get('$baseUrl/user/$id');
//     if(response.statusCode == 200){
//       return userFromJson(response.body);
//     }else return null;
//   }


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
      final User user = _data['data']['user'].map<User>((model) => User.fromJson(model as Map<String, dynamic>));
      print(response.body);
      return user;
    } else {
      throw Exception('Failed to load Users');
    }
 }
}