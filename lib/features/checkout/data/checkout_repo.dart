import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/features/checkout/data/checkout_model.dart';

class CheckoutRepo {
  final ApiService _apiService = ApiService();

  Future<dynamic> checkoutData(CheckoutRequestModel checkoutModel) async {
    try {
      final response = await _apiService.postData(
        "/orders",
        checkoutModel.toJson(),
      );
      return response;
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
