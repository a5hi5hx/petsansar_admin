import 'dart:convert';

class User {
  final String token;
  final String id;
  final String email;
  final String name;
  final String phoneNumber;
  final String image;

  User({
    required this.token,
    required this.id,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.image,
  });

 Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'token': token,
      'name': name,
      'phoneNumber': phoneNumber,
      'image': image,
    };
  }
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      token: map['token'] ?? '',
      id: map['_id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      image: map['image'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

}
