import 'package:booknstyle/data/models/user_profile/user_profile_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_info/user_profile.dart';
import '../../domain/repositories/user_profile_repository.dart';
import 'package:booknstyle/data/data_sources/remote/user_profile_remote_data_source.dart';
import 'package:booknstyle/core/network/network_info.dart'; // Add this import, adjust the path if needed

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileRemoteDataSource remoteDataSource;
  final NetworkInfo
  networkInfo; // Assuming you have a NetworkInfo for connectivity checks

  UserProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

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
    if (await networkInfo.isConnected) {
      try {
        final userProfileModel = UserProfileModel(
          userId: userProfile.userId,
          firstName: userProfile.firstName,
          lastName: userProfile.lastName,
          phoneNumber: userProfile.phoneNumber,
          gender: userProfile.gender,
          dateOfBirth: userProfile.dateOfBirth,
        );
        await remoteDataSource.saveUserProfile(userProfileModel);
        return Right(userProfile);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
