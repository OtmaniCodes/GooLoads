import 'dart:convert';

class UserModel {
  final String? uid;
  final String? name;
  final String? email;
  final String? imageUrl;

  UserModel({this.uid, this.name, this.email, this.imageUrl});


  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
