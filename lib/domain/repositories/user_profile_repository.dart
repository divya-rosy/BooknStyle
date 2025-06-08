import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_info/user_profile.dart';

abstract class UserProfileRepository {
  Future<Either<Failure, UserProfile>> getUserProfile(); // Updated parameter type

  Future<Either<Failure, UserProfile>> saveUserProfile(UserProfile userProfile); // Updated return type
}