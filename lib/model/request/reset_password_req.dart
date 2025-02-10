class ResetPasswordReq {
  String? email;

  ResetPasswordReq({
    this.email,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
      };

  factory ResetPasswordReq.fromJson(Map<String, dynamic> json) => ResetPasswordReq(
        email: json['email'],
      );
}
