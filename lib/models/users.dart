import 'dart:convert';

class User{
  late int? id;
  late String? email;
  late String? full_name;
  late String? token;

  User({required this.id, required this.email, required this.full_name, required this.token});

  factory User.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return User(
      id: json['id'],
      email: json['email'],
      full_name: json['full_name'],
      token: json['token'],
    );

  }

  void printAttributes() {
    print("id: ${this.id}\n");
    print("email: ${this.email}\n");
    print("name: ${this.full_name}\n");
    print("token: ${this.token}\n");
  }

}