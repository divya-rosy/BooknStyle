import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:booknstyle/domain/usecases/user_info/get_user_profile.dart';
import 'package:booknstyle/domain/usecases/user_info/save_user_profile.dart' as user_info_usecases;

import 'user_profile_event.dart';
import 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final GetUserProfileUseCase getUserProfile;
  final user_info_usecases.SaveUserProfileUseCase saveUserProfile;

  UserProfileBloc({required this.getUserProfile, required this.saveUserProfile}) : super(UserProfileInitial()) {
    on<FetchUserProfile>((event, emit) async {
      emit(UserProfileLoading());
      final result = await getUserProfile(NoParams());
      emit(result.fold(
        (failure) => UserProfileError(failure.toString()),
        (userProfile) => UserProfileLoaded(userProfile),
      ));
    });
    on<SaveUserProfile>((event, emit) async {
      try {
        await saveUserProfile.call(event.userProfile); // Explicitly call the `call` method
        emit(UserProfileLoaded(event.userProfile)); // Emit a valid state after saving
      } catch (e) {
        emit(UserProfileError(e.toString()));
      }
    });
  }
}