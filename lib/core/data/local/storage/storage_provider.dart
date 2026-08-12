import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


final storageProvider = Provider<StorageController>((ref) {
  return StorageController();
});

class StorageController {

  Future<void> saveString(String key, String value) async{
    final pref = await SharedPreferences.getInstance();
    await pref.setString(key, value);
  }
  Future<String?> getString(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }
  Future<void> removeStore(String key) async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(key);
  }
}