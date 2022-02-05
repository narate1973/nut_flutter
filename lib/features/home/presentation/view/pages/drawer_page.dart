import 'package:flutter/material.dart';
import 'package:nut_flutter/myApp/bloc/auth_cubit/auth_cubit.dart';
import 'package:provider/src/provider.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage._({Key? key}) : super(key: key);

  static Widget create() => const DrawerPage._();

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
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
                Navigator.pop(context);
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
