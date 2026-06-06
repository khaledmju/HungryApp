// will have inside the functions
import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/core/utils/pref_helper.dart';
import 'package:hungry/features/auth/data/user_model.dart';

class AuthRepo {
  final ApiService _apiService = ApiService();

  ///login

  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await _apiService.postData("/login", {
        "email": email,
        "password": password,
      });
      print(response);
      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response["message"];
        final code = response["code"];
        final data = response["data"];

        if (code != 200 || data == null) {
          throw ApiError(message: msg);
        }

        final user = UserModel.fromJson(response["data"]);

        // save token
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }

        return user;
      } else {
        throw ApiError(message: "UnExpected Error From Server");
      }
    } on DioException catch (e) {
      throw ApiExceptions.handelError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  ///signup

  ///get profile

  ///update profile

  ///logout
}
