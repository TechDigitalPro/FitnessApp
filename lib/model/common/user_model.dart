import '../../utils/api_utils.dart';

class UserModel {
  String? id;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? role;
  String? mobile;
  String? active;
  String? bio;
  String? address;
  String? createdAt;
  String? city;
  String? street;
  String? state;
  String? zip;
  String? imageUrl;

  UserModel({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
    this.mobile,
    this.active,
    this.bio,
    this.address,
    this.createdAt,
    this.city,
    this.street,
    this.state,
    this.zip,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'role': role,
        'mobile_number': mobile,
        'active': active,
        'bio': bio,
        'address': address,
        'created_at': createdAt,
        'city': city,
        'street': street,
        'state': state,
        'zip': zip,
        'photo': imageUrl,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        firstName: json['firstname'],
        lastName: json['lastname'],
        email: json['email'],
        role: json['role'],
        mobile: json['mobile_number'],
        active: json['active'],
        bio: json['bio'],
        address: json['address'],
        createdAt: json['created_at'],
        city: json['city'],
        street: json['street'],
        state: json['state'],
        zip: json['zip'],
        imageUrl: json['photo'] == null ? null : json['photo'].toString().contains("http") ? json['photo'].toString() : ApiUtils.urlImagePre + json['photo'].toString(),
      );
}
