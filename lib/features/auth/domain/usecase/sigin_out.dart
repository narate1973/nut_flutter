import '../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'dart:async';

import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repo.dart';

class SignOut extends Usecase<bool, NoParams> {
  final AuthRepo authRepo;
  SignOut({required this.authRepo});
  @override
  FutureOr<Either<Failure, bool>> call(NoParams params) async {
    return Right(await authRepo.signOut());
  }
}
