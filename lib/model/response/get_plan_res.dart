
import 'dart:convert';

import '../common/plan_model.dart';

class GetPlansRes {
  bool? status;
  String? message;
  List<PlanModel>? list;

  GetPlansRes({
    this.status,
    this.message,
    this.list,
  });

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'list': list == null ? null : jsonEncode(list),
      };

  factory GetPlansRes.fromJson(Map<String, dynamic> json) => GetPlansRes(
        status: json['status'],
        message: json['message'],
        list: json['list'] == null ? [] : (json['list'] as List).map((model) => PlanModel.fromJson(model)).toList(),
      );
}
