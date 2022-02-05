import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nut_flutter/features/home/presentation/bloc/home_navigation_cubit/home_navigation_cubit.dart';
import 'package:nut_flutter/features/home/presentation/view/pages/drawer_page.dart';

import 'bottom_pages/bottom_pages.dart';

class HomeNavigationPage extends StatelessWidget {
  const HomeNavigationPage._({Key? key}) : super(key: key);

  static Widget create() => BlocProvider(
        create: (context) => HomeNavigationCubit(),
        child: const HomeNavigationPage._(),
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
          drawer: DrawerPage.create(),
          appBar: AppBar(
            title: const Text('Home'),
            centerTitle: true,
          ),
          body: screen[cubit.state.navIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.state.navIndex,
            onTap: (int index) => cubit.onNavTaped(index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'หน้าหลัก',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_rounded),
                label: 'ตรวจจุด',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notification_add_outlined),
                label: 'แจ้งเตือน',
              ),
            ],
          ),
        );
      },
    );
  }
}
