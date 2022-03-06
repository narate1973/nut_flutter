import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';

class LoginButton extends StatelessWidget {
  final bool isLoading;
  final bool isValid;
  final void Function() onPressed;

  const LoginButton({
    Key? key,
    required this.isLoading,
    required this.onPressed,
    required this.isValid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppButton(
      key: const Key('login-page-login-button'),
      isLoading: isLoading,
      enabled: isValid,
      title: 'Login',
      onPressed: onPressed,
    );
  }
}
