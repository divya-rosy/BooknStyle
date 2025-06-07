import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String userId; // Added userId for consistency with other entities
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final String gender; // Changed Char to String

  const UserProfile({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.phoneNumber,
    required this.dateOfBirth,
  });
  UserProfile copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    DateTime? dateOfBirth,
  }) {
    return UserProfile(
      userId: userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }

  @override
  List<Object> get props => [firstName, lastName, gender, phoneNumber, dateOfBirth];
}