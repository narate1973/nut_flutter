import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nut_flutter/core/core.dart';
import 'package:nut_flutter/features/auth/presentation/bloc/login_cubit/login_cubit.dart';
import 'package:nut_flutter/myApp/bloc/app_cubit/app_cubit.dart';
import 'package:nut_flutter/myApp/view/my_app.dart';

class LoginPage extends StatelessWidget {
  const LoginPage._({Key? key}) : super(key: key);

  static Widget create() => BlocProvider(
        key: const Key('login-page'),
        create: (context) => LoginCubit(appCubit: context.read<AppCubit>()),
        child: const LoginPage._(),
      );

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 30, left: 30),
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state.isSuccess) {
                    loginCubit.emitClearState();
                  }
                  if (state.isFailed) {
                    loginCubit.emitClearStatus();
                    AppToast.showError(
                      context,
                      key: const Key('login-page-failed-toast'),
                      message: 'login failed',
                    );
                  }
                },
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      const SizedBox(height: 16),
                      AppTextField(
                        key: const Key('login-page-email-field'),
                        hintText: 'Email',
                        onChange: (String email) {
                          loginCubit.onEmailChanged(email);
                        },
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        key: const Key('login-page-password-field'),
                        hintText: 'Password',
                        obscureText: true,
                        onChange: (String password) {
                          loginCubit.onPasswordChanged(password);
                        },
                      ),
                      const SizedBox(height: 16),
                      AppButton(
                        key: const Key('login-page-login-button'),
                        isLoading: state.isLoading,
                        enabled: state.isValid,
                        title: 'Login',
                        onPressed: () {
                          loginCubit.onLoginPressed();
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
