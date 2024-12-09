class AuthUser{
  String email;

  AuthUser({required this.email});

  AuthUser.fromJson(Map<String, dynamic> json):
      email = json["email"];

  Map<String, dynamic> toJson(){
    return {
      "email": email,
    };
  }
}