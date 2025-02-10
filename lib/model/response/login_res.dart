
import '../common/user_model.dart';

class LoginRes {
  bool? status;
  String? message;
  String? token;
  UserModel? user;

  LoginRes({
    this.status,
    this.message,
    this.token,
    this.user,
  });

  Map<String, dynamic> toJson() => {
        'status': status,
        'token': token,
        'message': message,
        'user': user?.toJson(),
      };

  factory LoginRes.fromJson(Map<String, dynamic> json) => LoginRes(
        status: json['status'],
        token: json['token'],
        message: json['message'],
        user: json['user'] == null ? null : UserModel.fromJson(json['user']),
      );
}
