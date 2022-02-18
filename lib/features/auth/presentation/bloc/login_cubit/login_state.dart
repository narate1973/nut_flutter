part of 'login_cubit.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool isLoading;
  final bool isSuccess;
  final bool isFailed;

  const LoginState({
    this.email = '',
    this.password = '',
    this.isFailed = false,
    this.isLoading = false,
    this.isSuccess = false,
  });

  bool get isValid => email.isNotEmpty && password.isNotEmpty;

  LoginState clearStatus() => const LoginState(
        isFailed: false,
        isLoading: false,
        isSuccess: false,
      );

  LoginState loading() => copyWith(
        isLoading: true,
        isFailed: false,
        isSuccess: false,
      );

  LoginState success() => copyWith(
        isSuccess: true,
        isLoading: false,
        isFailed: false,
      );

  LoginState failed() => copyWith(
        isFailed: true,
        isLoading: false,
        isSuccess: false,
      );

  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    bool? isSuccess,
    bool? isFailed,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailed: isFailed ?? this.isFailed,
    );
  }

  @override
  List<Object> get props => [email, password, isLoading, isSuccess, isFailed];
}
