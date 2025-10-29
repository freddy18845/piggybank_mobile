import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // Create storage
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Write a value
  Future<void> writeValue(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // Read a value
  Future<String?> readValue(String key) async {
    return await _storage.read(key: key);
  }

  // Delete a value
  Future<void> deleteValue(String key) async {
    await _storage.delete(key: key);
  }

  // Delete all
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}



GetIt locator = GetIt.instance;

void setupLocator() {
  // Initialize the SecureStorageService
  locator.registerLazySingleton(() => SecureStorageService());


}
