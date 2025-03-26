import '../../utils/api_utils.dart';

class WorkoutModel {
  String? id;
  String? name;
  String? description;
  String? videoUrl;
  String? imageUrl;
  String? createdAt;
  String? ownerId;
  String? duration;

  WorkoutModel({
    this.id,
    this.name,
    this.description,
    this.videoUrl,
    this.imageUrl,
    this.createdAt,
    this.ownerId,
    this.duration,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'video': videoUrl,
        'image': imageUrl,
        'created_at': createdAt,
        'owner_id': ownerId,
        'duration': duration,
      };

  factory WorkoutModel.fromJson(Map<String, dynamic> json) => WorkoutModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        videoUrl: json['video'] == null ? null : ApiUtils.urlVideoPre + json['video'].toString(),
        imageUrl: json['image'] == null ? null : ApiUtils.urlImagePre + json['image'].toString(),
        createdAt: json['created_at'],
        ownerId: json['owner_id'],
        duration: json['duration'],
      );
}
