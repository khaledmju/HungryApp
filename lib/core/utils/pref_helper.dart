import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static const String _tokenKey = "auth_token";

  // we use static on fun to access the fun from any where in app

  static Future<void> saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(_tokenKey);
  }

  static Future<void> clearToken() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove(_tokenKey);
  }
}

//
// import 'package:shared_preferences/shared_preferences.dart';
//
// class PrefHelper {
//   static const String _tokenKey = "auth_token";
//
//   // بنعرف متغير ثابت للـ preferences
//   static late final SharedPreferences _pref;
//
//   // بنستدعي هذه الدالة مرة واحدة فقط في الـ main() قبل الـ runApp
//   static Future<void> init() async {
//     _pref = await SharedPreferences.getInstance();
//   }
//
//   // هلق صار فيك تستخدم _pref فوراً بدون await وبدون تكرار السطر
//   static Future<void> saveToken(String token) async {
//     await _pref.setString(_tokenKey, token);
//   }
//
//   static String? getToken() {
//     return _pref.getString(_tokenKey); // حتى الدالة ما عاد تحتاج تكون Future!
//   }
//
//   static Future<void> clearToken() async {
//     await _pref.remove(_tokenKey);
//   }
// }



// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await PrefHelper.init(); // التجهيز لمرة واحدة فقط هنا
//   runApp(const MyApp());
// }