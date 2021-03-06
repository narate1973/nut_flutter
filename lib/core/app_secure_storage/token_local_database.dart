import 'package:nut_flutter/core/app_secure_storage/app_secure_storage.dart';
import 'package:nut_flutter/core/app_secure_storage/models/auth_token_model.dart';
import 'package:nut_flutter/core/utils/logger.dart';

class TokenDatabase extends AppSecureLocalDatabase {
  const TokenDatabase();

  static const accessTokenKey = 'access_token';
  static const refreshTokenKey = 'refresh_token';

  Future<TokenModel> loadToken() async {
    final String accessToken = await loadSecure(key: accessTokenKey, defaultData: '');
    final String refreshToken = await loadSecure(key: refreshTokenKey, defaultData: '');
    return TokenModel(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  Future<void> saveToken({required TokenModel token}) async {
    Log.i(token);
    final String accessToken = token.accessToken;
    final String refreshToken = token.refreshToken;
    await saveSecure(key: accessTokenKey, data: accessToken);
    await saveSecure(key: refreshTokenKey, data: refreshToken);
  }

  Future<void> deleteToken() async {
    await saveSecure(key: accessTokenKey, data: '');
    await saveSecure(key: refreshTokenKey, data: '');
  }
}
