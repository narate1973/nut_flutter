import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/exceptions/firebase_login_exception.dart';
import 'auth_api_service.dart';
import 'firebase_service.dart';
import 'requests/login_request.dart';
import 'responses/test_response.dart';

abstract class AuthRemoteDatasource {
  Future<TestResponse> test();
  Future<Either<Exception, String>> login({required String email, required String password});
  bool chekAuth();
  Future<void> signOut();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final LoginApiService loginApiService;
  final FirebaseService firebaseService;

  AuthRemoteDatasourceImpl({
    required this.loginApiService,
    required this.firebaseService,
  });

  @override
  Future<TestResponse> test() async {
    final response = await loginApiService.test();
    return response.data!;
  }

  @override
  Future<Either<Exception, String>> login({required String email, required String password}) async {
    try {
      await firebaseService.login(request: LoginRequest(email: email, password: password));
      final firebaseToken = await firebaseService.getTokenID();
      if (firebaseToken != null) {
        return Right(firebaseToken);
      } else {
        return Left(FirebaseNoToken());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Left(FirebaseLoginUserNotFound());
      } else if (e.code == 'wrong-password') {
        return Left(FirebaseLoginWrongPassword());
      } else {
        return Left(FirebaseAuthException(code: e.code));
      }
    }
  }

  @override
  bool chekAuth() {
    return firebaseService.isSiginIn();
  }

  @override
  Future<void> signOut() {
    return firebaseService.signOut();
  }
}
