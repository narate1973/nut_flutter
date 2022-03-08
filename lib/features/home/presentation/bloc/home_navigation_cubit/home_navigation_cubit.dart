import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'dart:developer' as developer;

import '../../../../auth/domain/repository/auth_repo.dart';

part 'home_navigation_state.dart';

class HomeNavigationCubit extends Cubit<HomeNavigationState> {
  final AuthRepo authRepo;
  HomeNavigationCubit({required this.authRepo}) : super(const HomeNavigationState());

  void onNavTaped(int index) {
    emit(state.copyWith(navIndex: index));
  }

  void onTest() async {
    final data = await authRepo.test();
    developer.log(data);
  }
}
