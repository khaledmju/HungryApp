import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/core/network/dio_client.dart';

class ApiService {
  final DioClient _dioClient = DioClient();

  /// get
  Future<dynamic> getData(String endpoint) async {
    try {
      final response = await _dioClient.dio.get(endpoint);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handelError(e);
    }
  }

  ///post
  Future<dynamic> postData(String endpoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.post(endpoint, data: body);

      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handelError(e);
    }
  }

  /// put / update
  Future<dynamic> updateData(String endpoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.put(endpoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handelError(e);
    }
  }

  /// delete
  Future<dynamic> deleteData(String endpoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.delete(endpoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handelError(e);
    }
  }
}
