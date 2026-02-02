import 'package:shared_preferences/shared_preferences.dart';

class StorageManagement{

  // ------------ Add Data On Local Storage ------------
  static Future<void> setStringStorage(String name, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(name, value);
  }

  // ------------ Get Data From Local Storage ------------
  static Future<String?> getStorage(String name) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(name); // Return null if data is empty
  }

  // ------------ Remove Data From Local Storage ------------
  static removeStorage(String name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(name);
  }

}