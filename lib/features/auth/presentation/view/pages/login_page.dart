import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/core.dart';
import '../../bloc/login_cubit/login_cubit.dart';
import '../widgets/templates/login_template.dart';

import '../../bloc/auth_cubit/auth_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage._({Key? key}) : super(key: key);

  static Widget create() => BlocProvider(
        key: const Key('login-page'),
        create: (context) => GetIt.I<LoginCubit>(),
        child: const LoginPage._(),
      );

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    final authCubit = context.read<AuthCubit>();
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          loginCubit.emitClearState();
          authCubit.checkAuth();
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
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: const Center(child: LoginTemplate()),
      ),
    );
  }
}
