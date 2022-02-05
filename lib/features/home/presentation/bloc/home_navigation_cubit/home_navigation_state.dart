part of 'home_navigation_cubit.dart';

@immutable
class HomeNavigationState extends Equatable {
  final int navIndex;

  const HomeNavigationState({
    this.navIndex = 0,
  });

  HomeNavigationState copyWith({int? navIndex}) {
    return HomeNavigationState(
      navIndex: navIndex ?? this.navIndex,
    );
  }

  @override
  List<Object?> get props => [navIndex];
}
