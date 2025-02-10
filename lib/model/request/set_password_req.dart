class SetPasswordReq {
  String? email;
  String? password;
  String? code;

  SetPasswordReq({
    this.email,
    this.password,
    this.code,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'code': code,
      };

  factory SetPasswordReq.fromJson(Map<String, dynamic> json) => SetPasswordReq(
        email: json['email'],
        password: json['password'],
        code: json['code'],
      );
}
