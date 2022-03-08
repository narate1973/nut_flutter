import 'package:nut_flutter/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'dart:async';

import 'package:nut_flutter/core/usecase/usecase.dart';
import 'package:nut_flutter/features/auth/domain/repository/auth_repo.dart';

class SignOut extends Usecase<bool, NoParams> {
  final AuthRepo authRepo;
  SignOut({required this.authRepo});
  @override
  FutureOr<Either<Failure, bool>> call(NoParams params) async {
    return Right(await authRepo.signOut());
  }
}
