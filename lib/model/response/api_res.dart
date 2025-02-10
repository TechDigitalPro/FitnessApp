class ApiRes {
  bool? status;
  String? message;

  ApiRes({
    this.status,
    this.message,
  });

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
      };

  factory ApiRes.fromJson(Map<String, dynamic> json) => ApiRes(
        status: json['status'],
        message: json['message'],
      );
}
