import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:nut_flutter/core/core.dart';
import 'package:nut_flutter/core/network/app_api_service.dart';
import 'package:nut_flutter/features/home/presentation/view/pages/home_navigation_page.dart';
import 'package:nut_flutter/features/auth/presentation/view/pages/login_page.dart';
import 'package:nut_flutter/myApp/bloc/auth_cubit/auth_cubit.dart';
import 'package:nut_flutter/myApp/view/app_splash_screen.dart';
import 'package:nut_flutter/myApp/view/overlay_layout.dart';

class MyApp extends StatelessWidget {
  const MyApp._({Key? key}) : super(key: key);

  static Widget create() => const MyApp._();

  static String appName = FlutterConfig.get(AppEnv.appNameField);

  static Future<void> setUpApplciation() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterConfig.loadEnvVariables();
    await Firebase.initializeApp();
    AppApiService.setUp(baseURL: FlutterConfig.get(AppEnv.baseURL));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OverlayLayout(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthed) {
              return HomeNavigationPage.create();
            }
            if (state is AuthUnAuthed) {
              return LoginPage.create();
            }
            return const AppSplashScreen();
          },
        ),
      ),
    );
  }
}
