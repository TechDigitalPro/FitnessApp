

import '../common/user_model.dart';

class VerifyEmailRes {
  bool? status;
  String? message;
  UserModel? user;

  VerifyEmailRes({
    this.status,
    this.message,
    this.user,
  });

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'user': user?.toJson(),
      };

  factory VerifyEmailRes.fromJson(Map<String, dynamic> json) => VerifyEmailRes(
        status: json['status'],
        message: json['message'],
        user: json['user'] == null ? null : UserModel.fromJson(json['user']),
      );
}
