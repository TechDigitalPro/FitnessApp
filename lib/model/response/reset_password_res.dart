class ResetPasswordRes {
  bool? status;
  String? code;
  String? message;

  ResetPasswordRes({
    this.status,
    this.code,
    this.message,
  });

  Map<String, dynamic> toJson() => {
        'status': status,
        'code': code,
        'message': message,
      };

  factory ResetPasswordRes.fromJson(Map<String, dynamic> json) => ResetPasswordRes(
        status: json['status'],
        code: json['code'],
        message: json['message'],
      );
}
