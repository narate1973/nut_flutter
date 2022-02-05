import 'package:flutter/material.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage._({Key? key}) : super(key: key);

  static Widget create() => const DrawerPage._();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Theme.of(context).primaryColor,
        child: ListView(
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
          ],
        ),
      ),
    );
  }
}
