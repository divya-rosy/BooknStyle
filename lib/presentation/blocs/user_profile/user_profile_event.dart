import 'package:booknstyle/domain/entities/user_info/user_profile.dart';
import 'package:equatable/equatable.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchUserProfile extends UserProfileEvent {}

class SaveUserProfile extends UserProfileEvent {
  final UserProfile userProfile;

  const SaveUserProfile(this.userProfile);
}
