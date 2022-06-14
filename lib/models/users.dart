// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.user,
  });

  List<User> user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": List<dynamic>.from(user.map((x) => x.toJson())),
      };
}

class User {
  User({
    this.id,
    required this.email,
    this.oauthUid,
    this.oauthProvider,
    this.username,
    required this.fullName,
    required this.avatar,
    required this.banned,
    this.lastLogin,
    this.lastActivity,
    required this.dateCreated,
    this.forgotExp,
    this.rememberTime,
    this.rememberExp,
    this.verificationCode,
    this.topSecret,
    this.ipAddress,
    this.createdBy,
    this.updatedBy,
    this.updatedAt,
    required this.createdAt,
    required this.avatarThumbnail,
    required this.group,
  });

  String? id;
  String email;
  dynamic oauthUid;
  dynamic oauthProvider;
  String? username;
  String fullName;
  String avatar;
  String banned;
  dynamic lastLogin;
  dynamic lastActivity;
  DateTime dateCreated;
  dynamic forgotExp;
  dynamic rememberTime;
  dynamic rememberExp;
  dynamic verificationCode;
  dynamic topSecret;
  dynamic ipAddress;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic updatedAt;
  DateTime createdAt;
  String avatarThumbnail;
  List<Group> group;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        oauthUid: json["oauth_uid"],
        oauthProvider: json["oauth_provider"],
        username: json["username"],
        fullName: json["full_name"],
        avatar: json["avatar"],
        banned: json["banned"],
        lastLogin: json["last_login"] == null
            ? null
            : DateTime.parse(json["last_login"]),
        lastActivity: json["last_activity"] == null
            ? null
            : DateTime.parse(json["last_activity"]),
        dateCreated: DateTime.parse(json["date_created"]),
        forgotExp: json["forgot_exp"],
        rememberTime: json["remember_time"],
        rememberExp: json["remember_exp"],
        verificationCode: json["verification_code"],
        topSecret: json["top_secret"],
        // ignore: prefer_if_null_operators
        ipAddress: json["ip_address"] == null ? null : json["ip_address"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        updatedAt: json["updated_at"],
        createdAt: DateTime.parse(json["created_at"]),
        avatarThumbnail: json["avatar_thumbnail"],
        group: List<Group>.from(json["group"].map((x) => Group.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "oauth_uid": oauthUid,
        "oauth_provider": oauthProvider,
        "username": username,
        "full_name": fullName,
        "avatar": avatar,
        "banned": banned,
        // ignore: prefer_null_aware_operators
        "last_login": lastLogin == null ? null : lastLogin.toIso8601String(),
        // ignore: prefer_null_aware_operators
        "last_activity":
            // ignore: prefer_null_aware_operators
            lastActivity == null ? null : lastActivity.toIso8601String(),
        "date_created": dateCreated.toIso8601String(),
        "forgot_exp": forgotExp,
        "remember_time": rememberTime,
        "remember_exp": rememberExp,
        "verification_code": verificationCode,
        "top_secret": topSecret,
        // ignore: prefer_if_null_operators
        "ip_address": ipAddress == null ? null : ipAddress,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "updated_at": updatedAt,
        "created_at": createdAt.toIso8601String(),
        "avatar_thumbnail": avatarThumbnail,
        "group": List<dynamic>.from(group.map((x) => x.toJson())),
      };
}

class Group {
  Group({
    required this.userId,
    required this.groupId,
    this.createdBy,
    this.updatedBy,
    this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.name,
    required this.priority,
    required this.definition,
  });

  String userId;
  String groupId;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic updatedAt;
  String createdAt;
  String id;
  String name;
  String priority;
  String definition;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        userId: json["user_id"],
        groupId: json["group_id"],
        // ignore: prefer_if_null_operators
        createdBy: json["created_by"] == null ? null : json["created_by"],
        updatedBy: json["updated_by"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
        id: json["id"],
        name: json["name"],
        priority: json["priority"],
        definition: json["definition"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "group_id": groupId,
        // ignore: prefer_if_null_operators
        "created_by": createdBy == null ? null : createdBy,
        "updated_by": updatedBy,
        "updated_at": updatedAt,
        "created_at": createdAt,
        "id": id,
        "name": name,
        "priority": priority,
        "definition": definition,
      };
}
