class UserModel {
  final String id;
  final String password;
  final String gender;
  final String nationality;
  final String phone;
  final String name;
  final String dateOfBirth;
  final String email;

  UserModel({
    required this.id,
    required this.password,
    required this.gender,
    required this.nationality,
    required this.phone,
    required this.name,
    required this.dateOfBirth,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      password: json['password'],
      gender: json['gender'],
      nationality: json['nationality'],
      phone: json['phone'],
      name: json['name'],
      dateOfBirth: json['dateOfBirth'],
      email: json['email'],
    );
  }
}
