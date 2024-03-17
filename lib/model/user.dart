// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String token;
  String id;
  String name;
  String email;
  String password;
  int v;

  User({
    required this.token,
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        token: json["token"],
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
        "__v": v,
      };
}
