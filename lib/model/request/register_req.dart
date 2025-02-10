class RegisterReq {
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? role;

  RegisterReq({
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.role
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'role': role,
      };

  factory RegisterReq.fromJson(Map<String, dynamic> json) => RegisterReq(
        name: json['name'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        password: json['password'],
        role: json['role'],
      );
}
