import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nut_flutter/myApp/bloc/app_cubit/app_cubit.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AppCubit appCubit;
  late final StreamSubscription _userSubscription;
  AuthCubit({required this.appCubit}) : super(AuthLoading()) {
    appCubit.emitLoading(true);
    _checkAuth();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  void _checkAuth() async {
    _userSubscription = FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        print('User is signed in!');
        emit(AuthAuthed());
        appCubit.emitLoading(false);
      } else {
        print('User is currently signed out!');
        emit(AuthUnAuthed());
        appCubit.emitLoading(false);
      }
    });
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    emit(AuthUnAuthed());
  }
}
