import 'package:booknstyle/data/models/user_profile/user_profile_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_info/user_profile.dart';
import '../../domain/repositories/user_profile_repository.dart';
import 'package:booknstyle/data/data_sources/remote/user_profile_remote_data_source.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileRemoteDataSource remoteDataSource;

  UserProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserProfile>> getUserProfile() async {
    try {
      final userProfile = await remoteDataSource.getUserProfile();
      return Right(userProfile);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

   @override
  Future<Either<Failure, UserProfile>> saveUserProfile(UserProfile userProfile) async {
    try {
      await remoteDataSource.saveUserProfile(UserProfileModel as UserProfileModel); // Assuming this method exists
      return Right(userProfile);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}