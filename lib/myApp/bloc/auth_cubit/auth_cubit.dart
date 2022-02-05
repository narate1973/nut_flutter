import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nut_flutter/myApp/bloc/app_cubit/app_cubit.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AppCubit appCubit;
  AuthCubit({required this.appCubit}) : super(AuthInitial());

  void checkAuth() async {
    emit(AuthLoading());
    appCubit.emitLoading(true);
    await Future.delayed(const Duration(seconds: 1));
    emit(AuthAuthed());
    appCubit.emitLoading(false);
  }
}
