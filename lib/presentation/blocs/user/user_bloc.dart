import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:booknstyle/domain/usecases/user/sign_up_user_usecase.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/user/user.dart';
import '../../../domain/usecases/user/sign_in_user_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final SignUpUseCase _signUpUseCase;
  UserBloc(this._signUpUseCase, {required SignUpUseCase signUpUseCase}) : super(UserInitial()) {
    on<SignUpUser>(_onSignUp);
    on<CheckUser>(_onCheckUser);
  }

  FutureOr<void> _onSignUp(SignUpUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _signUpUseCase(event.params);
      result.fold(
        (failure) => emit(UserLoggedFail(failure)),
        (user) => emit(UserLogged(user)),
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }
}
FutureOr<void> _onCheckUser(CheckUser event, Emitter<UserState> emit) async {
  emit(UserInitial());
}
