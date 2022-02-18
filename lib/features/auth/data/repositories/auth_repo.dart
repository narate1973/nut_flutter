import 'package:nut_flutter/features/auth/data/datasources/locals/auth_local_datasource.dart';
import 'package:nut_flutter/features/auth/data/datasources/remotes/auth_remote_datasource.dart';

abstract class AuthRepoInterface {
  Future<void> logout();
  Future<void> login();
  Future<bool> checkAuth();
}

class AuthRepo implements AuthRepoInterface {
  AuthRepo({
    required AuthRemoteDatasource authRemoteDatasource,
    required AuthLocalDatasource authLocalDatasource,
  })  : _authRemoteDatasource = authRemoteDatasource,
        _authLocalDatasource = authLocalDatasource;

  final AuthRemoteDatasource _authRemoteDatasource;
  final AuthLocalDatasource _authLocalDatasource;

  @override
  Future<bool> checkAuth() {
    // TODO: implement checkAuth
    throw UnimplementedError();
  }

  @override
  Future<void> login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
