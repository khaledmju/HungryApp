import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';

class ApiExceptions {
  // static to access the fun from any where in app
  static ApiError handelError(DioException exception) {
    final statusCode = exception.response?.statusCode;
    final data = exception.response?.data;

    if (data is Map<String, dynamic> && data["message"] != null) {
      return ApiError(message: data["message"], statusCode: statusCode);
    }

    if (statusCode == 302) {
      return ApiError(message: "The email has already been taken");
    }
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(message: "Connection timeout. Please try again.");

      case DioExceptionType.sendTimeout:
        return ApiError(message: "Request TimeOut , Please try again");

      case DioExceptionType.receiveTimeout:
        return ApiError(message: "Response TimeOut , Please try again");

      default:
        return ApiError(message: "something went wrong");
    }
  }
}
