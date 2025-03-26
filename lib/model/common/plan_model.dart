
class PlanModel {
  String? id;
  String? name;
  String? description;
  String? workoutIds;
  String? trainerId;
  String? price;

  PlanModel({
    this.id,
    this.name,
    this.description,
    this.workoutIds,
    this.trainerId,
    this.price,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'workout_ids': workoutIds,
        'trainer_id': trainerId,
        'price': price,
      };

  factory PlanModel.fromJson(Map<String, dynamic> json) => PlanModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        workoutIds: json['workout_ids'],
        trainerId: json['trainer_id'],
        price: json['price'],
      );
}
