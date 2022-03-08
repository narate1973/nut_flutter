import '../../../../core/exceptions/firebase_login_exception.dart';
import '../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/failure/login_failure.dart';
import '../../../../core/network/app_api_service.dart';
import '../datasources/locals/auth_local_datasource.dart';
import '../datasources/remotes/auth_remote_datasource.dart';

import '../../domain/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl({
    required this.authLocalDatasource,
    required this.authRemoteDatasource,
  });

  final AuthRemoteDatasource authRemoteDatasource;
  final AuthLocalDatasource authLocalDatasource;

  @override
  Future<Either<Failure, bool>> login({required String email, required String password}) async {
    final login = await authRemoteDatasource.login(email: email, password: password);
    return login.fold(
      (exception) {
        if (exception is FirebaseNoToken) {
          return Left(LoginNoTokenFailure());
        } else {
          return Left(WrongPasswordFailure());
        }
      },
      (token) async {
        AppApiService.setUpAccessToken(token);
        await authLocalDatasource.cachedToken(token);
        return const Right(true);
      },
    );
  }

  @override
  Future<String> test() async {
    final data = await authRemoteDatasource.test();
    return data.message;
  }

  @override
  Future<bool> checkAuth() async {
    final isAuthed = authRemoteDatasource.chekAuth();
    if (isAuthed) {
      final token = await authLocalDatasource.getToken();
      AppApiService.setUpAccessToken(token);
      await authLocalDatasource.cachedToken(token);
    }
    return isAuthed;
  }

  @override
  Future<bool> signOut() async {
    await authRemoteDatasource.signOut();
    return true;
  }
}
