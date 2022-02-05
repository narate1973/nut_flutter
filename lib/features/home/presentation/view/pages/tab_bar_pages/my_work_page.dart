import 'package:flutter/material.dart';

class MyWorkPage extends StatelessWidget {
  const MyWorkPage._({Key? key}) : super(key: key);

  static Widget create() => const MyWorkPage._();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('my work page'),
    );
  }
}
