import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../bloc/home_navigation_cubit/home_navigation_cubit.dart';
import '../widgets/atoms/home_bottom_nav_item.dart';
import '../widgets/home_drawer.dart';

import 'bottom_pages/bottom_pages.dart';

class HomeNavigationPage extends StatelessWidget {
  const HomeNavigationPage._({Key? key}) : super(key: key);

  static Widget create() => BlocProvider(
        create: (context) => GetIt.I<HomeNavigationCubit>(),
        child: const HomeNavigationPage._(
          key: Key('home-navigation-page'),
        ),
      );

  static final screen = [
    HomeBottomPage.create(),
    PatrolBottomPage.create(),
    NotificationBottomPage.create(),
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeNavigationCubit>();
    return BlocBuilder<HomeNavigationCubit, HomeNavigationState>(
      builder: (context, state) {
        return Scaffold(
          drawer: const HomeDrawer(),
          appBar: AppBar(
            title: const Text('Home'),
            centerTitle: true,
          ),
          body: screen[state.navIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.navIndex,
            onTap: (int index) => cubit.onNavTaped(index),
            items: const [
              HomeBottomNavItem.home,
              HomeBottomNavItem.patrol,
              HomeBottomNavItem.notification,
            ],
          ),
        );
      },
    );
  }
}
