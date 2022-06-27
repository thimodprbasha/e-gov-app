import 'dart:convert';

class User {
  final String ?  userID;
  final String  email;
  final String  password;

  User({
     this.userID,
    required this.email,
    required this.password});

  factory User.fromJson(Map<dynamic , dynamic> json) {
    return User(
        userID: json["id"],
        email : json["email"],
        password : json['password']
    );
  }

  String toJson () {
    return json.encode({
      "id" : userID,
      "password": password ,
      "email": email
    });
  }

}
