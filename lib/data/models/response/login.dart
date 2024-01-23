import 'dart:convert';

class Login {
  final String name;
  final String image;
  final int id;
  final DateTime creationAt;
  final DateTime updatedAt;

  Login({
    required this.name,
    required this.image,
    required this.id,
    required this.creationAt,
    required this.updatedAt,
  });

  factory Login.fromJson(String str) => Login.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Login.fromMap(Map<String, dynamic> json) => Login(
        name: json["name"],
        image: json["image"],
        id: json["id"],
        creationAt: DateTime.parse(json["creationAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "image": image,
        "id": id,
        "creationAt": creationAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
