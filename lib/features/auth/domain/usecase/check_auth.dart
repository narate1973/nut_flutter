import 'dart:async';

import '../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repo.dart';

class CheckAuth extends Usecase<bool, NoParams> {
  final AuthRepo authRepo;
  CheckAuth({required this.authRepo});
  @override
  FutureOr<Either<Failure, bool>> call(NoParams params) async {
    return Right(await authRepo.checkAuth());
  }
}
