import 'dart:convert';

import 'package:http/http.dart' as http;
import '../api.dart';

class AuthAPI extends BaseAPI {

  Future<http.Response> signUp(String fullname, String email,
      String password) async {
    var body = jsonEncode({
        'full_name': fullname,
        'email': email,
        'password': password
    });
                                    
    http.Response response =
    await http.post(Uri.parse(super.registerPath), headers: super.headers, body: body);
    
    return response;
  }

  Future<http.Response> login(String email, String password) async {
    var body = jsonEncode({'email': email, 'password': password});
    http.Response response =
    await http.post(Uri.parse(super.loginPath), headers: super.headers, body: body);
    var data = jsonDecode(response.body);

    print('this is $data');
    print(response.statusCode);

    return response;
  }


  Future<http.Response> logout(int id, String token) async {
    var body = jsonEncode({'id': id, 'token': token});

    http.Response response = await http.post(Uri.parse(super.logoutPath),
        headers: super.headers, body: body);

    return response;
  }

}