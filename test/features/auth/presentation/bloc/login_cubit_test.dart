import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nut_flutter/core/failure/login_failure.dart';
import 'package:nut_flutter/features/app/bloc/app_cubit/app_cubit.dart';
import 'package:nut_flutter/features/auth/domain/usecase/login.dart';
import 'package:nut_flutter/features/auth/presentation/bloc/login_cubit/login_cubit.dart';

import 'login_cubit_test.mocks.dart';

class MockAppCubit extends MockCubit<AppState> implements AppCubit {}

@GenerateMocks([Login])
void main() {
  late LoginCubit loginCubit;
  late MockAppCubit mockAppCubit;
  late MockLogin mockLogin;

  setUp(() {
    mockLogin = MockLogin();
    mockAppCubit = MockAppCubit();
    loginCubit = LoginCubit(appCubit: mockAppCubit, login: mockLogin);
  });

  const tLoginParams = Params(email: 'test', password: 'test');
  const tResult = true;

  blocTest(
    'should emit state.failed() when login is failed',
    build: () {
      when(mockLogin(any)).thenAnswer((_) async => Left(WrongPasswordFailure()));
      return loginCubit;
    },
    act: (LoginCubit cubit) {
      cubit.onEmailChanged('test');
      cubit.onPasswordChanged('test');
      cubit.onLoginPressed();
    },
    verify: (_) {
      verify(mockLogin(tLoginParams));
    },
    expect: () => [
      const LoginState(
        email: 'test',
        password: '',
        isFailed: false,
        isLoading: false,
        isSuccess: false,
      ),
      const LoginState(
        email: 'test',
        password: 'test',
        isFailed: false,
        isLoading: false,
        isSuccess: false,
      ),
      const LoginState(
        email: 'test',
        password: 'test',
        isFailed: false,
        isLoading: true,
        isSuccess: false,
      ),
      const LoginState(
        email: 'test',
        password: 'test',
        isFailed: true,
        isLoading: false,
        isSuccess: false,
      ),
    ],
  );
  blocTest(
    'should emit state.success() when login success',
    build: () {
      when(mockLogin(any)).thenAnswer((_) async => const Right(tResult));
      return loginCubit;
    },
    act: (LoginCubit cubit) {
      cubit.onEmailChanged('test');
      cubit.onPasswordChanged('test');
      cubit.onLoginPressed();
    },
    verify: (_) {
      verify(mockLogin(tLoginParams));
    },
    expect: () => [
      const LoginState(
        email: 'test',
        password: '',
        isFailed: false,
        isLoading: false,
        isSuccess: false,
      ),
      const LoginState(
        email: 'test',
        password: 'test',
        isFailed: false,
        isLoading: false,
        isSuccess: false,
      ),
      const LoginState(
        email: 'test',
        password: 'test',
        isFailed: false,
        isLoading: true,
        isSuccess: false,
      ),
      const LoginState(
        email: 'test',
        password: 'test',
        isFailed: false,
        isLoading: false,
        isSuccess: true,
      ),
    ],
  );
}
