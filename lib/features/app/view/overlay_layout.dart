import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nut_flutter/features/app/bloc/app_cubit/app_cubit.dart';

class OverlayLayout extends StatelessWidget {
  final Widget child;
  const OverlayLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: child,
        ),
        BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return Visibility(
              visible: state.isLoading,
              child: loadingScreen,
            );
          },
        ),
      ],
    );
  }

  static final Widget loadingScreen = Container(
    color: Colors.black.withOpacity(0.5),
    child: const Center(
      child: CircularProgressIndicator(),
    ),
  );
}
