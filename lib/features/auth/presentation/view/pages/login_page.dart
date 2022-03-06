import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nut_flutter/core/core.dart';
import 'package:nut_flutter/features/auth/presentation/bloc/login_cubit/login_cubit.dart';
import 'package:nut_flutter/features/auth/presentation/view/widgets/templates/login_template.dart';
import 'package:nut_flutter/myApp/bloc/app_cubit/app_cubit.dart';

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
    return BlocListener<LoginCubit, LoginState>(
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
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: const Center(child: LoginTemplate()),
      ),
    );
  }
}
