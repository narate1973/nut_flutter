import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nut_flutter/core/usecase/usecase.dart';

import 'package:nut_flutter/features/app/bloc/app_cubit/app_cubit.dart';
import 'package:nut_flutter/features/auth/domain/usecase/check_auth.dart';
import 'package:nut_flutter/features/auth/domain/usecase/sigin_out.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AppCubit appCubit;
  final CheckAuth _checkAuth;
  final SignOut _signOut;

  AuthCubit({
    required this.appCubit,
    required CheckAuth checkAuth,
    required SignOut signOut,
  })  : _checkAuth = checkAuth,
        _signOut = signOut,
        super(AuthLoading()) {
    appCubit.emitLoading(true);
  }

  void checkAuth() async {
    final result = await _checkAuth(NoParams());
    result.fold(
      (failure) => emit(AuthFailed()),
      (success) {
        if (success) {
          emit(AuthAuthed());
        } else {
          emit(AuthUnAuthed());
        }
      },
    );
  }

  void signOut() async {
    emit(AuthLoading());
    await _signOut(NoParams());
    emit(AuthUnAuthed());
  }
}
