class ResendVerificationReq {
  String? email;

  ResendVerificationReq({
    this.email,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
      };

  factory ResendVerificationReq.fromJson(Map<String, dynamic> json) => ResendVerificationReq(
        email: json['email'],
      );
}
