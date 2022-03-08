import 'package:flutter/material.dart';
import '../organisms/login_form.dart';

class LoginTemplate extends StatelessWidget {
  const LoginTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: const LoginForm(),
    );
  }
}
