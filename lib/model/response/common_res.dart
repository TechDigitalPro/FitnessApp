
import '../common/user_model.dart';

class CommonRes {
  bool? status;
  String? message;
  UserModel? user;

  CommonRes({
    this.status,
    this.message,
    this.user,
  });

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'user': user?.toJson(),
      };

  factory CommonRes.fromJson(Map<String, dynamic> json) => CommonRes(
        status: json['status'],
        message: json['message'],
        user: json['user'] == null ? null : UserModel.fromJson(json['user']),
      );
}
