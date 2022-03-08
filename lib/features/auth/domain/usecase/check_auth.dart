import 'dart:async';

import 'package:nut_flutter/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:nut_flutter/core/usecase/usecase.dart';
import 'package:nut_flutter/features/auth/domain/repository/auth_repo.dart';

class CheckAuth extends Usecase<bool, NoParams> {
  final AuthRepo authRepo;
  CheckAuth({required this.authRepo});
  @override
  FutureOr<Either<Failure, bool>> call(NoParams params) async {
    return Right(await authRepo.checkAuth());
  }
}
