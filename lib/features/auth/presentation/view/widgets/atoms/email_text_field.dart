import 'package:flutter/material.dart';
import 'package:nut_flutter/core/widget/app_text_field.dart';

class EmailTextField extends StatelessWidget {
  final Function(String email) onChange;
  const EmailTextField({Key? key, required this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      key: const Key('login-page-email-field'),
      hintText: 'Email',
      onChange: onChange,
    );
  }
}
