// will have inside the functions
import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/core/utils/pref_helper.dart';
import 'package:hungry/features/auth/data/user_model.dart';

class AuthRepo {
  final ApiService _apiService = ApiService();

  bool isGuest = false;

  UserModel? _currentUser;

  ///login

  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await _apiService.postData("/login", {
        "email": email,
        "password": password,
      });
      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response["message"];
        final code = response["code"];
        final data = response["data"];

        // هاد الشرط مو احباري هاد مستخدم بحيث اذا رجع الكود 200 وكان لازم 422
        // يعني بشكل عام حماية اذا كان الباك هيك عامل
        // يعني ممكن نشيل هاد الجزء من الكود
        if (code != 200 || data == null) {
          throw ApiError(message: msg);
        }
        final user = UserModel.fromJson(data);

        // save token
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }

        isGuest = false;
        _currentUser = user;
        return user;
      } else {
        throw ApiError(message: "UnExpected Error From Server");
      }
    } on DioException catch (e) {
      throw ApiExceptions.handelError(e); // <--- هذا السطر لن يعمل أبداً!
      // لانو بالاساس عملنا بالapi service
    }
    /*
    *فشل الـ Parsing (تحليل البيانات): إذا نجح الطلب ورجع كود 200، ولكن تركيبة الـ JSON مكسورة أو تختلف عما يتوقعه
    *UserModel.fromJson(data) (مثلاً السيرفر أرسل حقل id كـ String بينما الموديل يتوقعه int). سيتسبب
    هذا في TypeError، مما يجعله يقفز إلى الـ catch (e) العامة.
    * */
    // اي بالمختصر خطا مني
    catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  ///signup

  Future<UserModel?> singUp(String name, String email, String password) async {
    try {
      final response = await _apiService.postData("/register", {
        "name": name,
        "email": email,
        "password": password,
      });

      if (response is ApiError) {
        throw response;
      }
      if (response is Map<String, dynamic>) {
        final code = response["code"];
        final msg = response["message"];
        final data = response["data"];

        // هاد الشرط مو احباري هاد مستخدم بحيث اذا رجع الكود 200 وكان لازم 422
        // يعني بشكل عام حماية اذا كان الباك هيك عامل
        // يعني ممكن نشيل هاد الجزء من الكود
        if (code != 200 && data == null) {
          throw ApiError(message: msg);
        }

        final user = UserModel.fromJson(data);

        if (user.token != null) {
          PrefHelper.saveToken(user.token!);
        }
        isGuest = false;
        _currentUser = user;
        return user;
      } else {
        throw ApiError(message: "UnExpected Error ");
      }
    } on DioException catch (e) {
      throw ApiExceptions.handelError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  ///get profile

  Future<UserModel?> getProfile() async {
    try {
      final token = await PrefHelper.getToken();

      if (token == null || token == "guest") {
        return null;
      }

      final response = await _apiService.getData("/profile");

      final user = UserModel.fromJson(response["data"]);
      _currentUser = user;
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handelError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  ///update profile

  // Future
  Future<UserModel?> updateProfile({
    required String name,
    required String email,
    required String address,
    String? visa,
    String? imagePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        "name": name,
        "email": email,
        "address": address,
        if (visa != null && visa.isNotEmpty) "Visa": visa,

        if (imagePath != null && imagePath.isNotEmpty)
          "image": await MultipartFile.fromFile(
            imagePath,
            filename: "profile.jpg",
          ),
      });

      final response = await _apiService.postData("/update-profile", formData);
      if (response is ApiError) {
        throw response;
      }
      if (response is Map<String, dynamic>) {
        final code = response["code"];
        final msg = response["message"];
        final data = response["data"];

        if (code != 200 && data == null) {
          throw ApiError(message: msg);
        }

        final user = UserModel.fromJson(data);
        _currentUser = user;
        return user;
      } else {
        throw ApiError(message: "UnExpected Error ");
      }
    } on DioException catch (e) {
      throw ApiExceptions.handelError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  ///logout
  Future<void> logout() async {
    final response = await _apiService.postData("/logout", {});
    print(response);
    await PrefHelper.clearToken();
    _currentUser = null;
    isGuest = true;
  }

  /// guest
  Future<void> continueAsGuest() async {
    isGuest = true;
    _currentUser = null;
    await PrefHelper.saveToken("guest");
  }

  /// auto login
  Future<UserModel?> autoLogin() async {
    final token = await PrefHelper.getToken();

    if (token == null || token == "guest") {
      isGuest = true;
      _currentUser = null;
      return null;
    }
    try {
      final user = await getProfile();
      _currentUser = user;
      return user;
    } catch (e) {
      await PrefHelper.clearToken();
      isGuest = true;
      _currentUser = null;
      return null;
    }
  }

  UserModel? get currentUser => _currentUser;

  bool get isLoggedIn => !isGuest && _currentUser != null;
}
