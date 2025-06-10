import 'package:booknstyle/data/repositories/user_profile_repository_impl.dart';
import 'package:booknstyle/domain/repositories/user_profile_repository.dart' as user_profile_repo;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../network/network_info.dart';
import 'package:booknstyle/data/data_sources/remote/user_profile_remote_data_source.dart';
import 'package:booknstyle/domain/usecases/user_info/get_user_profile.dart';
import 'package:booknstyle/domain/usecases/user_info/save_user_profile.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:booknstyle/data/data_sources/remote/user_remote_data_source.dart';
import 'package:booknstyle/data/data_sources/local/user_local_data_source.dart';
import 'package:booknstyle/data/repositories/user_repository_impl.dart';
import 'package:booknstyle/domain/repositories/user_repository.dart';
import 'package:booknstyle/domain/usecases/user/sign_up_user_usecase.dart';
import 'package:booknstyle/presentation/blocs/user/user_bloc.dart';
import 'package:booknstyle/presentation/blocs/user_profile/user_profile_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> init(GetIt sl) async {
  sl.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker.createInstance());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  final sharedPreferences = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => secureStorage);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(client: sl<http.Client>()),
  );
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(
      sharedPreferences: sl<SharedPreferences>(),
      secureStorage: sl<FlutterSecureStorage>(),
    ),
  );
  sl.registerLazySingleton<UserProfileRemoteDataSource>(
    () => UserProfileRemoteDataSourceImpl(client: sl<http.Client>()),
  );

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl<UserRemoteDataSource>(),
      localDataSource: sl<UserLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // Register UserProfileRepository
  sl.registerLazySingleton<user_profile_repo.UserProfileRepository>(
    () => UserProfileRepositoryImpl(
      remoteDataSource: sl<UserProfileRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  sl.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(sl<UserRepository>()),
  );

  sl.registerFactory<UserBloc>(() => UserBloc(
        sl<SignUpUseCase>(),
        signUpUseCase: sl<SignUpUseCase>(),
      ));

  sl.registerLazySingleton<GetUserProfileUseCase>(
    () => GetUserProfileUseCase(sl<user_profile_repo.UserProfileRepository>()), // Fix: Add the prefix
  );

  sl.registerLazySingleton<SaveUserProfileUseCase>(
    () => SaveUserProfileUseCase(sl<user_profile_repo.UserProfileRepository>()),
  );

  sl.registerFactory<UserProfileBloc>(() => UserProfileBloc(
        getUserProfile: sl<GetUserProfileUseCase>(),
        saveUserProfile: sl<SaveUserProfileUseCase>(),
      ));
}