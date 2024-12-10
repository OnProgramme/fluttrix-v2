import 'package:fluttrix/shared/helpers/generate.uuid.dart';

class User {
  User._({required this.email, required this.userId, required this.createdAt});
  final String userId;
  final String email;
  final DateTime createdAt;

  factory User.create({String? userId, required String email}) {
    return User._(
      userId: userId ?? generateUuid(),
      email: email,
      createdAt: DateTime.now(),
    );
  }

  User.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        email = json['email'],
        createdAt = DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "email": email,
    };
  }
}
