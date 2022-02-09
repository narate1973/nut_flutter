import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nut_flutter/features/home/presentation/view/pages/home_navigation_page.dart';
import 'package:nut_flutter/features/login/presentation/view/pages/login_page.dart';
import 'package:nut_flutter/myApp/bloc/auth_cubit/auth_cubit.dart';
import 'package:nut_flutter/myApp/view/app_splash_screen.dart';
import 'package:nut_flutter/myApp/view/overlay_layout.dart';

class MyApp extends StatelessWidget {
  const MyApp._({Key? key}) : super(key: key);

  static Widget create() => const MyApp._();

  static String appName = 'Nut Flutter';

  static Future<void> setUpApplciation() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    final apps = Firebase.apps.first;
    print('=====> apps: ${apps.options.projectId}');
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
