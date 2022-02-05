import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_navigation_state.dart';

class HomeNavigationCubit extends Cubit<HomeNavigationState> {
  HomeNavigationCubit() : super(const HomeNavigationState());

  void onNavTaped(int index) {
    emit(state.copyWith(navIndex: index));
  }
}
