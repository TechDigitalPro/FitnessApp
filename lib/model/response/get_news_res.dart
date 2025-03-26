
import 'dart:convert';

import '../common/news_model.dart';

class GetNewsRes {
  bool? status;
  String? message;
  List<NewsModel>? list;

  GetNewsRes({
    this.status,
    this.message,
    this.list,
  });

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'list': list == null ? null : jsonEncode(list),
      };

  factory GetNewsRes.fromJson(Map<String, dynamic> json) => GetNewsRes(
        status: json['status'],
        message: json['message'],
        list: json['list'] == null ? [] : (json['list'] as List).map((model) => NewsModel.fromJson(model)).toList(),
      );
}
