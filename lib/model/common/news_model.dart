import '../../utils/api_utils.dart';

class NewsModel {
  String? id;
  String? title;
  String? content;
  String? imageUrl;
  String? createdAt;
  String? userId;

  NewsModel({
    this.id,
    this.title,
    this.content,
    this.imageUrl,
    this.createdAt,
    this.userId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'image': imageUrl,
        'date_created1': createdAt,
        'user_id': userId,
      };

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        imageUrl: json['image'] == null ? null : ApiUtils.urlImagePre + json['image'].toString(),
        createdAt: json['date_created1'],
        userId: json['user_id'],
      );
}
