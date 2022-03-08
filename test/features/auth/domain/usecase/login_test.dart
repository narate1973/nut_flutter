import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nut_flutter/core/failure/login_failure.dart';
import 'package:nut_flutter/features/auth/domain/repository/auth_repo.dart';
import 'package:nut_flutter/features/auth/domain/usecase/login.dart';

import 'login_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late Login login;
  late MockAuthRepo mockAuthRepo;

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    login = Login(authRepo: mockAuthRepo);
  });
  const tIsSuccess = true;

  test(
    'should return false when login unsuccessfully',
    () async {
      // arrange
      when(mockAuthRepo.login(email: anyNamed('email'), password: anyNamed('password')))
          .thenAnswer((_) async => Left(LoginNoTokenFailure()));
      // act
      final result = await login(const Params(email: 'test', password: 'test'));
      //assert
      expect(result, equals(Left(LoginNoTokenFailure())));
    },
  );
  test(
    'should return true when login successfully',
    () async {
      // arrange
      when(mockAuthRepo.login(email: anyNamed('email'), password: anyNamed('password')))
          .thenAnswer((_) async => const Right(tIsSuccess));
      // act
      final result = await login(const Params(email: 'test', password: 'test'));
      //assert
      expect(result, equals(const Right(tIsSuccess)));
    },
  );
}
