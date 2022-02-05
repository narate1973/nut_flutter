import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nut_flutter/myApp/bloc/app_cubit/app_cubit.dart';
import 'package:nut_flutter/myApp/bloc/auth_cubit/auth_cubit.dart';
import 'package:nut_flutter/myApp/view/my_app.dart';

Future<void> main() async {
  await MyApp.setUpApplciation();
  runApplication();
}

void runApplication() {
  final appCubit = AppCubit();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => appCubit),
        BlocProvider(create: (context) => AuthCubit(appCubit: appCubit)),
      ],
      child: MyApp.create(),
    ),
  );
}
