import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
    UserProfile({
        required this.status,
        required this.message,
        required this.data,
    });

    bool status;
    String message;
    Data data;

    factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
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

    ProfileUser user;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: ProfileUser.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
    };
}

class ProfileUser {
    ProfileUser({
        required this.id,
        required this.email,
         this.oauthUid,
         this.oauthProvider,
        required this.pass,
        required this.username,
        required this.fullName,
        required this.avatar,
        required this.banned,
        required this.lastLogin,
        this.lastActivity,
        required this.dateCreated,
         this.forgotExp,
         this.rememberTime,
         this.rememberExp,
         this.verificationCode,
         this.topSecret,
        required this.ipAddress,
        this.createdBy,
         this.updatedBy,
         this.updatedAt,
        required this.createdAt,
    });

    String id;
    String email;
    dynamic oauthUid;
    dynamic oauthProvider;
    String pass;
    String username;
    String fullName;
    String avatar;
    String banned;
    DateTime lastLogin;
    dynamic lastActivity;
    DateTime dateCreated;
    dynamic forgotExp;
    dynamic rememberTime;
    dynamic rememberExp;
    dynamic verificationCode;
    dynamic topSecret;
    String ipAddress;
    dynamic createdBy;
    dynamic updatedBy;
    dynamic updatedAt;
    DateTime createdAt;

    factory ProfileUser.fromJson(Map<String, dynamic> json) => ProfileUser(
        id: json["id"],
        email: json["email"],
        oauthUid: json["oauth_uid"],
        oauthProvider: json["oauth_provider"],
        pass: json["pass"],
        username: json["username"],
        fullName: json["full_name"],
        avatar: json["avatar"],
        banned: json["banned"],
        lastLogin: DateTime.parse(json["last_login"]),
        lastActivity: json["last_activity"],
        dateCreated: DateTime.parse(json["date_created"]),
        forgotExp: json["forgot_exp"],
        rememberTime: json["remember_time"],
        rememberExp: json["remember_exp"],
        verificationCode: json["verification_code"],
        topSecret: json["top_secret"],
        ipAddress: json["ip_address"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        updatedAt: json["updated_at"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "oauth_uid": oauthUid,
        "oauth_provider": oauthProvider,
        "pass": pass,
        "username": username,
        "full_name": fullName,
        "avatar": avatar,
        "banned": banned,
        "last_login": lastLogin.toIso8601String(),
        "last_activity": lastActivity,
        "date_created": dateCreated.toIso8601String(),
        "forgot_exp": forgotExp,
        "remember_time": rememberTime,
        "remember_exp": rememberExp,
        "verification_code": verificationCode,
        "top_secret": topSecret,
        "ip_address": ipAddress,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "updated_at": updatedAt,
        "created_at": createdAt.toIso8601String(),
    };
}
