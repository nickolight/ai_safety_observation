import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageDataSource {
  Future<void> writeToken(String token);
  Future<String?> readToken();
  Future<void> deleteToken();
}

class SecureStorageDataSourceImpl implements SecureStorageDataSource {
  final _storage = const FlutterSecureStorage();
  final _key = 'auth_token';

  @override
  Future<void> writeToken(String token) async {
    await _storage.write(key: _key, value: token);
  }

  @override
  Future<String?> readToken() async {
    return _storage.read(key: _key);
  }

  @override
  Future<void> deleteToken() async {
    await _storage.delete(key: _key);
  }
}
