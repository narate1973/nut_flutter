import '../../../../../core/app_secure_storage/models/auth_token_model.dart';
import '../../../../../core/app_secure_storage/token_local_database.dart';

abstract class AuthLocalDatasource {
  Future<void> cachedToken(String token);
  Future<String> getToken();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final TokenDatabase tokenDatabase;
  AuthLocalDatasourceImpl({required this.tokenDatabase});
  @override
  Future<void> cachedToken(String token) async {
    return tokenDatabase.saveToken(token: TokenModel(accessToken: token, refreshToken: token));
  }

  @override
  Future<String> getToken() async {
    final token = await tokenDatabase.loadToken();
    return token.accessToken;
  }
}
