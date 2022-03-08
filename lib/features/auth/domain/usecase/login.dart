import 'package:equatable/equatable.dart';
import '../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';

import '../repository/auth_repo.dart';

class Login implements Usecase<bool, Params> {
  final AuthRepo authRepo;
  Login({required this.authRepo});
  @override
  Future<Either<Failure, bool>> call(Params params) {
    return authRepo.login(email: params.email, password: params.password);
  }
}

class Params extends Equatable {
  final String email;
  final String password;
  const Params({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
