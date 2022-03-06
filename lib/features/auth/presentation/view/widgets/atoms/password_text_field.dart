import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';

class PasswordTextField extends StatelessWidget {
  final Function(String password) onchange;
  const PasswordTextField({Key? key, required this.onchange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      key: const Key('login-page-password-field'),
      hintText: 'Password',
      obscureText: true,
      onChange: onchange,
    );
  }
}
