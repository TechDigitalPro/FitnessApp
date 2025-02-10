
import 'dart:convert';

import '../common/workout_model.dart';

class GetWorkoutsRes {
  bool? status;
  String? message;
  List<WorkoutModel>? list;

  GetWorkoutsRes({
    this.status,
    this.message,
    this.list,
  });

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'list': list == null ? null : jsonEncode(list),
      };

  factory GetWorkoutsRes.fromJson(Map<String, dynamic> json) => GetWorkoutsRes(
        status: json['status'],
        message: json['message'],
        list: json['list'] == null ? [] : (json['list'] as List).map((model) => WorkoutModel.fromJson(model)).toList(),
      );
}
