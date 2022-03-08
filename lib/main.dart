import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/app/bloc/app_cubit/app_cubit.dart';
import 'features/app/view/my_app.dart';
import 'features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';

Future<void> main() async {
  await MyApp.setUpApplciation();
  runApplication();
}

void runApplication() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetIt.I<AppCubit>()),
        BlocProvider(create: (context) => GetIt.I<AuthCubit>()..checkAuth()),
      ],
      child: MyApp.create(),
    ),
  );
}
