class SetPlanReq {
  String? userId;
  String? planId;

  SetPlanReq({
    this.userId,
    this.planId,
  });

  Map<String, dynamic> toJson() => {
        'id': userId,
        'planId': planId,
      };

  factory SetPlanReq.fromJson(Map<String, dynamic> json) => SetPlanReq(
        userId: json['id'],
        planId: json['planId'],
      );
}
