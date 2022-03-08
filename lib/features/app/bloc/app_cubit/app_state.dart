part of 'app_cubit.dart';

class AppState extends Equatable {
  final bool isLoading;

  const AppState({this.isLoading = false});

  AppState copyWith({bool? isLoading}) {
    final newState = AppState(isLoading: isLoading ?? this.isLoading);
    return newState;
  }

  @override
  List<Object> get props => [isLoading];
}
