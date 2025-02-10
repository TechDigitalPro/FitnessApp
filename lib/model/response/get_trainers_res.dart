
import 'dart:convert';

import '../common/trainer_model.dart';

class GetTrainersRes {
  bool? status;
  String? message;
  List<TrainerModel>? list;

  GetTrainersRes({
    this.status,
    this.message,
    this.list,
  });

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'list': list == null ? null : jsonEncode(list),
      };

  factory GetTrainersRes.fromJson(Map<String, dynamic> json) => GetTrainersRes(
        status: json['status'],
        message: json['message'],
        list: json['list'] == null ? [] : (json['list'] as List).map((model) => TrainerModel.fromJson(model)).toList(),
      );
}
