import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nut_flutter/myApp/bloc/app_cubit/app_cubit.dart';

class MockAppCubit extends MockCubit<AppState> implements AppCubit {}

void main() {
  group('when listen', () {
    test('mock app cuit', () {
      final cubit = MockAppCubit();

      whenListen(cubit,
          Stream.fromIterable([const AppState(isLoading: false), const AppState(isLoading: true)]));
      expectLater(cubit.stream, emitsInOrder([const AppState(), const AppState(isLoading: true)]));
    });
  });

  group('when app cucbit called', () {
    blocTest<AppCubit, AppState>(
      'emit AppState(isLoading : false)',
      build: () => AppCubit(),
      act: (cubit) => cubit.emitLoading(false),
      // wait: const Duration(milliseconds: 300),
      expect: () => [const AppState()],
    );

    blocTest<AppCubit, AppState>(
      'emit AppState(isLoading : true)',
      build: () => AppCubit(),
      act: (cubit) => cubit.emitLoading(true),
      // wait: const Duration(milliseconds: 300),
      expect: () => [const AppState(isLoading: true)],
    );
  });
}
