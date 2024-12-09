import 'package:uuid/uuid.dart';

class User {
  User._({required this.email, required this.userId});
  final String userId;
  final String email;

  factory User.create({String? userId, required String email}) {
    return User._(
      userId: userId ?? Uuid().v4(),
      email: email,
    );
  }

  User.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        email = json['email'];

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "email": email,
    };
  }
}
