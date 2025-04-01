class GetMyPlanReq {
  String? planId;

  GetMyPlanReq({
    this.planId,
  });

  Map<String, dynamic> toJson() => {
        'planId': planId,
      };

  factory GetMyPlanReq.fromJson(Map<String, dynamic> json) => GetMyPlanReq(
        planId: json['planId'],
      );
}
