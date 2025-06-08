import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:booknstyle/domain/entities/user_info/user_profile.dart';
import 'package:booknstyle/domain/repositories/user_profile_repository.dart'; // Ensure this path is correct

class SaveUserProfileUseCase implements UseCase<UserProfile, UserProfile> {
  final UserProfileRepository repository;

  SaveUserProfileUseCase(this.repository);

  @override
  Future<Either<Failure, UserProfile>> call(UserProfile params) async {
    return await repository.saveUserProfile(params);
  }
}