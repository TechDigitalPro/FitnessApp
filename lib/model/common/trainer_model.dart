import '../../utils/api_utils.dart';

class TrainerModel {
  String? id;
  String? name;
  String? email;
  String? trainerCode;
  String? imageUrl;
  String? language;
  String? bio;
  String? specialty;
  String? createdAt;
  String? experienceLevel;
  String? offerings;
  String? ownerId;

  TrainerModel({
    this.id,
    this.name,
    this.email,
    this.trainerCode,
    this.imageUrl,
    this.language,
    this.bio,
    this.specialty,
    this.createdAt,
    this.experienceLevel,
    this.offerings,
    this.ownerId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'trainerCode': trainerCode,
        'photo': imageUrl,
        'language': language,
        'bio': bio,
        'specialty': specialty,
        'created_at': createdAt,
        'experience_level': experienceLevel,
        'offerings': offerings,
        'owner_id': ownerId,
      };

  factory TrainerModel.fromJson(Map<String, dynamic> json) => TrainerModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        trainerCode: json['trainerCode'],
        imageUrl: json['photo'] == null ? null : ApiUtils.urlImagePre + json['photo'].toString(),
        language: json['language'],
        bio: json['bio'],
        specialty: json['specialty'],
        createdAt: json['created_at'],
        experienceLevel: json['experience_level'],
        offerings: json['offerings'],
        ownerId: json['owner_id'],
      );
}
