import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nut_flutter/core/usecase/usecase.dart';
import 'package:nut_flutter/features/app/bloc/app_cubit/app_cubit.dart';
import 'package:nut_flutter/features/auth/domain/usecase/check_auth.dart';
import 'package:nut_flutter/features/auth/domain/usecase/sigin_out.dart';
import 'package:nut_flutter/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';

import 'auth_cubit_test.mocks.dart';

class MockAppCubit extends MockCubit<AppState> implements AppCubit {}

@GenerateMocks([CheckAuth])
@GenerateMocks([SignOut])
void main() {
  late AuthCubit authCubit;
  late MockCheckAuth mockCheckAuth;
  late MockSignOut mockSignOut;
  late MockAppCubit mockAppCubit;

  setUp(() {
    mockSignOut = MockSignOut();
    mockCheckAuth = MockCheckAuth();
    mockAppCubit = MockAppCubit();
    authCubit = AuthCubit(appCubit: mockAppCubit, checkAuth: mockCheckAuth, signOut: mockSignOut);
  });

  blocTest(
    'should emit unAuthed when call sign out',
    build: () {
      when(mockSignOut(any)).thenAnswer((_) async => const Right(true));
      return authCubit;
    },
    act: (AuthCubit cubit) => cubit.signOut(),
    verify: (_) {
      verify(mockSignOut(NoParams()));
    },
    expect: () => [
      AuthLoading(),
      AuthUnAuthed(),
    ],
  );
}
