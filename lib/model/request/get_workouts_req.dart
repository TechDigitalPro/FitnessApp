class GetWorkoutsReq {
  String? trainerId;

  GetWorkoutsReq({
    this.trainerId,
  });

  Map<String, dynamic> toJson() => {
        'trainer_id': trainerId,
      };

  factory GetWorkoutsReq.fromJson(Map<String, dynamic> json) => GetWorkoutsReq(
        trainerId: json['trainer_id'],
      );
}
