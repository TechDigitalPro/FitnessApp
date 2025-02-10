class LoginReq {
  String? email;
  String? password;

  LoginReq({
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };

  factory LoginReq.fromJson(Map<String, dynamic> json) => LoginReq(
        email: json['email'],
        password: json['password'],
      );
}
