class SetPlanReq {
  String? userId;
  String? planId;
  String? ownerId;

  SetPlanReq({
    this.userId,
    this.planId,
    this.ownerId,
  });

  Map<String, dynamic> toJson() => {
        'id': userId,
        'planId': planId,
        'ownerId': ownerId,
      };

  factory SetPlanReq.fromJson(Map<String, dynamic> json) => SetPlanReq(
        userId: json['id'],
        planId: json['planId'],
        ownerId: json['ownerId'],
      );
}
