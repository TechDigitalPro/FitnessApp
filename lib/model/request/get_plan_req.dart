class GetPlanReq {
  String? userId;

  GetPlanReq({
    this.userId,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
      };

  factory GetPlanReq.fromJson(Map<String, dynamic> json) => GetPlanReq(
        userId: json['userId'],
      );
}
