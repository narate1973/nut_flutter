import 'package:flutter/material.dart';

class NotificationBottomPage extends StatelessWidget {
  const NotificationBottomPage._({Key? key}) : super(key: key);

  static Widget create() => const NotificationBottomPage._();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Notification bottom page'),
    );
  }
}
