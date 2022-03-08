import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/home_navigation_cubit/home_navigation_cubit.dart';
import '../../../../auth/presentation/bloc/auth_cubit/auth_cubit.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final homeCubit = context.read<HomeNavigationCubit>();
    return Drawer(
      child: Material(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            DrawerHeader(
              child: Text(
                'Drawer Header',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                homeCubit.onTest();
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 3'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              key: const Key('sign-out-button'),
              title: const Text('sign out'),
              onTap: () {
                authCubit.signOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
