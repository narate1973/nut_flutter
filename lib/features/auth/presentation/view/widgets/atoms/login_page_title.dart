import 'package:flutter/material.dart';

import '../../../../../app/view/my_app.dart';

class LoginPageTitle extends StatelessWidget {
  const LoginPageTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Login',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          MyApp.appName,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
