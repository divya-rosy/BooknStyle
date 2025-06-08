import 'package:equatable/equatable.dart';
import 'package:booknstyle/domain/entities/user_info/user_profile.dart';
abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final UserProfile userProfile;

  const UserProfileLoaded(this.userProfile);

  @override
  List<Object> get props => [userProfile];
}

class UserProfileError extends UserProfileState {
  final String message;

  const UserProfileError(this.message);

  @override
  List<Object> get props => [message];
}