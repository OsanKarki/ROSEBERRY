import 'package:ecommerce_app/core/utils/storage_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStatusRepository {
  Future<bool> isAuthenticated() async {
    final token =
        await FlutterSecureStorage().read(key: StorageConstants.accessToken);
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }
  Future<String?>getAccessToken()async{
    final token =
        await FlutterSecureStorage().read(key: StorageConstants.accessToken);
    return token;

  }

  logout() async {
    await FlutterSecureStorage().delete(key: StorageConstants.accessToken);
  }
}
