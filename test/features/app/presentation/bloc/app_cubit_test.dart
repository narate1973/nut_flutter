import 'package:bloc_test/bloc_test.dart';
import 'package:nut_flutter/features/app/bloc/app_cubit/app_cubit.dart';

class MockAppCubit extends MockCubit<AppState> implements AppCubit {}

void main() {
  blocTest(
    'app cubit go loading true when ',
    build: () => AppCubit(),
    act: (AppCubit cubit) => cubit.emitLoading(false),
    expect: () => [const AppState(isLoading: false)],
  );
}
