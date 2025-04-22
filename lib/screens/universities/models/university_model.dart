import 'major_model.dart';

class UniversityModel {
  final String image;
  final String requirements;
  final String password;
  final List<Major> majors;
  final String address;
  final String phone;
  final String name;
  final String email;
  final String desc;
  String id;
  final String website;
  bool isAds;
  // bool isFavorite;

  UniversityModel({
    required this.image,
    required this.requirements,
    required this.password,
    required this.majors,
    required this.address,
    required this.phone,
    required this.name,
    required this.email,
    required this.desc,
    required this.id,
    required this.website,
    required this.isAds,
    // this.isFavorite = false,
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      image: json['image'],
      requirements: json['requirements'],
      password: json['password'],
      majors: (json['majors'] as List)
          .map((majorJson) => Major.fromJson(majorJson))
          .toList(),
      address: json['address'],
      phone: json['phone'],
      name: json['name'],
      email: json['email'],
      desc: json['desc'],
      id: json['id'],
      website: json['website'],
      isAds: json['isAds'] ?? false,
      // isFavorite: CacheHelper.isFavorite(json["id"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'requirements': requirements,
      'password': password,
      'majors': majors.map((m) => m.toJson()).toList(),
      'address': address,
      'phone': phone,
      'name': name,
      'email': email,
      'desc': desc,
      // 'id': id,
      'website': website,
      'isAds': isAds,
    };
  }
}
