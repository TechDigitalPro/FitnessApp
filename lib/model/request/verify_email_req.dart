class VerifyEmailReq {
  String? email;
  String? verificationCode;

  VerifyEmailReq({
    this.email,
    this.verificationCode,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'verification_code': verificationCode,
      };

  factory VerifyEmailReq.fromJson(Map<String, dynamic> json) => VerifyEmailReq(
        email: json['email'],
        verificationCode: json['verification_code'],
      );
}
