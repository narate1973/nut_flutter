import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';

abstract class AuthRepo {
  Future<bool> signOut();
  Future<Either<Failure, bool>> login({required String email, required String password});
  Future<bool> checkAuth();
  Future<String> test();
}
