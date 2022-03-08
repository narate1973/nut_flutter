import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/login_cubit/login_cubit.dart';
import '../atoms/email_text_field.dart';
import '../atoms/login_button.dart';
import '../atoms/login_page_title.dart';
import '../atoms/password_text_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const LoginPageTitle(),
        const SizedBox(height: 16),
        EmailTextField(
          onChange: (String email) {
            loginCubit.onEmailChanged(email);
          },
        ),
        const SizedBox(height: 16),
        PasswordTextField(
          onchange: (String password) {
            loginCubit.onPasswordChanged(password);
          },
        ),
        const SizedBox(height: 16),
        BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return LoginButton(
              isLoading: state.isLoading,
              isValid: state.isValid,
              onPressed: () {
                loginCubit.onLoginPressed();
              },
            );
          },
        ),
      ],
    );
  }
}
