import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/features/home/data/product_model.dart';

class HomeRepo {
  final ApiService _apiService = ApiService();

  ///get products
  Future<List<ProductModel>> getProduct() async {
    try {
      final response = await _apiService.getData("/products");
      List responseList = response["data"];

      return responseList.map((e) => ProductModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ApiExceptions.handelError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
