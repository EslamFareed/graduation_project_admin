import 'package:cloud_firestore/cloud_firestore.dart';

class UniversityModel {
  String? image;
  String? password;
  String? address;
  List<String>? majors;
  String? phone;
  String? name;
  String? email;
  String? desc;
  String? id;

  UniversityModel(
      {this.image,
      this.password,
      this.address,
      this.majors,
      this.phone,
      this.name,
      this.email,
      this.id,
      this.desc});

  UniversityModel.fromFirbase(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    id = json.id;
    image = json.data()['image'];
    password = json.data()['password'];
    address = json.data()['address'];
    majors = json.data()['majors'].cast<String>();
    phone = json.data()['phone'];
    name = json.data()['name'];
    email = json.data()['email'];
    desc = json.data()['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['password'] = this.password;
    data['address'] = this.address;
    data['majors'] = this.majors;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['email'] = this.email;
    data['desc'] = this.desc;
    return data;
  }
}
