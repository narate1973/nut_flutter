import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nut_flutter/features/app/bloc/app_cubit/app_cubit.dart';

import 'package:nut_flutter/features/auth/domain/usecase/login.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AppCubit appCubit;
  final Login login;
  LoginCubit({required this.appCubit, required this.login}) : super(const LoginState());

  void emitClearState() => emit(const LoginState());

  void emitClearStatus() => emit(state.clearStatus());

  void onEmailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void onPasswordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  void onLoginPressed() async {
    emit(state.loading());
    appCubit.emitLoading(true);
    final result = await login(Params(email: state.email, password: state.password));
    result.fold(
      (failure) {
        emit(state.failed());
        appCubit.emitLoading(false);
      },
      (success) {
        emit(state.success());
        appCubit.emitLoading(false);
      },
    );
  }
}
