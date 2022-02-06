import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nut_flutter/myApp/bloc/app_cubit/app_cubit.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AppCubit appCubit;
  LoginCubit({required this.appCubit}) : super(const LoginState());

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
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      emit(state.success());
      appCubit.emitLoading(false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      emit(state.failed());
      appCubit.emitLoading(false);
    } catch (e) {
      print(e);
      emit(state.failed());
      appCubit.emitLoading(false);
    }
  }
}
