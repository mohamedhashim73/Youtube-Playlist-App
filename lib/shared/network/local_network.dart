import 'package:shared_preferences/shared_preferences.dart';

class CacheNetwork{
  static late SharedPreferences sharedPref;

  static Future cacheInitialization() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  // set - get - delete - clear ( key , value )
 static Future<bool> insertToCache({required String key,required String value}) async {
    return await sharedPref.setString(key, value);
 }

 static Future<String?> getCacheData({required String key}) async {
    return sharedPref.getString(key);
 }

 static Future<bool> deleteCacheItem({required String key}) async {
    return await sharedPref.remove(key);
 }

}