import 'dart:convert';

class AuthRequestModel {
  final String email;
  final String password;

  AuthRequestModel({
    required this.email,
    required this.password,
  });

  factory AuthRequestModel.fromJson(String str) =>
      AuthRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthRequestModel.fromMap(Map<String, dynamic> json) =>
      AuthRequestModel(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "password": password,
      };
}
