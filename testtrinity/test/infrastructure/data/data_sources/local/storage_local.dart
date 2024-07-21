import 'package:shared_preferences/shared_preferences.dart';

class StorageLocal {
  static String USER_ID = 'user_id';

  Future<SharedPreferences> instance() async {
    var pref = await SharedPreferences.getInstance();

    return pref;
  }

  Future<void> setString(String key, String value) async {
    instance().then((pref) async {
      pref.setString(key, value);
    });
  }

  Future<String> getString(String key) async {
    var pref = await SharedPreferences.getInstance();
    String? val = pref.getString(key);
    return val ?? '';
  }

  Future<dynamic> storageSharedPreferenceDelete({required String key}) async {
    return instance().then((pref) async {
      if (key.isNotEmpty) {
        pref.remove(key);
      }
    });
  }
}
