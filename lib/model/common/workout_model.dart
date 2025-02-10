import '../../utils/api_utils.dart';

class WorkoutModel {
  String? id;
  String? name;
  String? description;
  String? videoUrl;
  String? createdAt;
  String? ownerId;

  WorkoutModel({
    this.id,
    this.name,
    this.description,
    this.videoUrl,
    this.createdAt,
    this.ownerId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'video_url': videoUrl,
        'created_at': createdAt,
        'owner_id': ownerId,
      };

  factory WorkoutModel.fromJson(Map<String, dynamic> json) => WorkoutModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        videoUrl: json['video_url'] == null ? null :
          json['video_url'].toString().contains('localhost') ? ApiUtils.urlVideoPre + json['video_url'].toString().split('/videos/')[1] : json['video_url'],
        createdAt: json['created_at'],
        ownerId: json['owner_id'],
      );
}
