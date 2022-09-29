//TODO: will add more attributes

import 'package:contra/model/gender.dart';

class User {
  final String id;
  final String name;
  final DateTime dob;
  final Gender gender;
  final String username;
  final String email;
  final int schoolId;
  final int hostelId;
  final String password;
  String? token;

  User({
    required this.id,
    required this.dob,
    required this.gender,
    required this.username,
    required this.schoolId,
    required this.hostelId,
    required this.password,
    required this.name,
    required this.email,
    this.token,
  });

  set setToken(String token) => this.token = token;

  User.fromJson(Map<String, dynamic> data)
      : id = data['id'] ?? '',
        dob = DateTime.parse(data['dob']),
        gender = _getGender(data['gender']),
        username = data['username'],
        schoolId = data['school_id'],
        hostelId = data['hostel_id'],
        password = data['password'] ?? '',
        name = data['name'],
        token = data['token'],
        email = data['email'] ?? '';

  static Gender _getGender(String initial) =>
      Gender.MALE.initial == initial ? Gender.MALE : Gender.FEMALE;

  Map<String, dynamic> get toJson => {
        'dob': dob.toIso8601String(),
        'gender': gender.initial,
        'username': username,
        'school_id': schoolId,
        'hostel_id': hostelId,
        'password': password,
        'name': name,
        'email': email,
        'token': token,
      };
}
