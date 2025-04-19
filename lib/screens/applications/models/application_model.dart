import 'package:graduation_project_admin/screens/users/models/user_model.dart';

import '../../universities/models/major_model.dart';
import '../../universities/models/university_model.dart';

class StudentApplication {
  final DateTime date;
  final String motherPhone;
  final String fatherJob;
  final UniversityModel university;
  final String motherName;
  final String idNumber;
  final String type;
  final String highSchoolName;
  final String motherJob;
  final Major major;
  final String highSchoolPercentage;
  final String fatherPhone;
  final String idPhoto;
  final UserModel user;
  final String certificatePhoto;
  final String status;
  final String interviewDate;
  final String interviewDesc;
  final String id;

  StudentApplication({
    required this.date,
    required this.motherPhone,
    required this.fatherJob,
    required this.university,
    required this.motherName,
    required this.idNumber,
    required this.type,
    required this.highSchoolName,
    required this.motherJob,
    required this.major,
    required this.highSchoolPercentage,
    required this.fatherPhone,
    required this.idPhoto,
    required this.user,
    required this.certificatePhoto,
    required this.status,
    required this.interviewDate,
    required this.interviewDesc,
    required this.id,
  });

  factory StudentApplication.fromJson(Map<String, dynamic> json, String id) {
    return StudentApplication(
        date: DateTime.parse(json['date']),
        motherPhone: json['motherPhone'],
        fatherJob: json['fatherJob'],
        university: UniversityModel.fromJson(json['university']),
        motherName: json['motherName'],
        idNumber: json['idNumber'],
        type: json['type'],
        highSchoolName: json['highSchoolName'],
        motherJob: json['motherJob'],
        major: Major.fromJson(json['major']),
        highSchoolPercentage: json['highSchoolPercentage'],
        fatherPhone: json['fatherPhone'],
        idPhoto: json['idPhoto'],
        user: UserModel.fromJson(json['user'], json['user']["uid"]),
        certificatePhoto: json['certificatePhoto'],
        status: json['status'],
        interviewDesc: json['interviewDesc'],
        interviewDate: json['interviewDate'],
        id: id);
  }
}
