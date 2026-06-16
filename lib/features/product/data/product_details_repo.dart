import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/features/product/data/toppings_model.dart';

class ProductDetailsRepo {
  final ApiService _apiService = ApiService();

  /// get toppings
  Future<List<ToppingsModel>?> getToppings() async {
    try {
      final response = await _apiService.getData("/toppings");
      List responseDataList = response["data"];
      return responseDataList.map((e) => ToppingsModel.fromJson(e)).toList();
    }
    on DioException catch (e) {
      throw ApiExceptions.handelError(e);
    }
    catch (e) {
      return [];
    }
  }

  /// get side options
  Future<List<ToppingsModel>?> getSideOptions() async {
    try {
      final response = await _apiService.getData("/side-options");
      List responseDataList = response["data"];
      return responseDataList.map((e) => ToppingsModel.fromJson(e)).toList();
    }
    on DioException catch (e) {
      throw ApiExceptions.handelError(e);
    }
    catch (e) {
      return [];
    }
  }
}
