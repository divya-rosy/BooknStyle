import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:booknstyle/domain/entities/user_info/user_profile.dart';
import 'package:booknstyle/domain/repositories/user_profile_repository.dart'; // Import the real UserProfileRepository

class GetUserProfileUseCase implements UseCase<UserProfile, NoParams> {
  final UserProfileRepository repository;

  GetUserProfileUseCase(this.repository);

  @override
  Future<Either<Failure, UserProfile>> call(NoParams params) async {
    return await repository.getUserProfile();
  }
}