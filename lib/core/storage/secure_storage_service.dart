import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService._();
  static final SecureStorageService instance = SecureStorageService._();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Sets a value in secure storage.
  Future<void> set(StorageKey key, Map value) {
    return _storage.write(key: key.name, value: jsonEncode(value));
  }

  /// Get Map from secure
  Future<Map?> get(StorageKey key) async {
    final response = await _storage.read(key: key.name);
    if (response != null) {
      return jsonDecode(response);
    }
    return null;
  }

  /// Delete value from secure storage.
  Future<void> delete(StorageKey key) {
    return _storage.delete(key: key.name);
  }
}

enum StorageKey {
  userData,
}
