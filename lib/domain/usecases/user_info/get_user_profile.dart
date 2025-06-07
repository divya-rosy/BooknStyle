import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:booknstyle/domain/entities/user_info/user_profile.dart';
// If the import above does not resolve the class, define a placeholder below or ensure the file exists:
abstract class UserProfileRepository {
  Future<Either<Failure, UserProfile>> getUserProfile();
}

class GetUserProfileUseCase implements UseCase<UserProfile, NoParams> {
  final UserProfileRepository repository;

  GetUserProfileUseCase(this.repository);

  @override
  Future<Either<Failure, UserProfile>> call(NoParams params) async {
    return await repository.getUserProfile();
  }
}