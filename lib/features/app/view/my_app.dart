import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import '../../../core/core.dart';
import '../../../core/network/app_api_service.dart';
import '../../home/presentation/view/pages/home_navigation_page.dart';
import '../../auth/presentation/view/pages/login_page.dart';
import 'app_splash_screen.dart';
import 'overlay_layout.dart';
import '../../../injection/injection.dart' as di;

import '../../auth/presentation/bloc/auth_cubit/auth_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp._({Key? key}) : super(key: key);

  static Widget create() => const MyApp._();

  static String appName = FlutterConfig.get(AppEnv.appNameField);

  static Future<void> setUpApplciation() async {
    await di.init();
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
