import 'package:booknstyle/domain/entities/user_info/user_profile.dart';

class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.userId,
    required super.firstName,
    required super.lastName,
    required super.phoneNumber,
    required super.gender, 
    required super.dateOfBirth,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      userId: json['userId'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      gender: json['gender'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
    };
  }
}