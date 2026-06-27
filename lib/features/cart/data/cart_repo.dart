import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/features/cart/data/cart_model.dart';

class CartRepo {
  final ApiService _apiService = ApiService();

  /// add to cart

  Future<void> addToCart(CartRequestModel cartData) async {
    try {
      print("call add to cart ");
      final response = await _apiService.postData(
        "/cart/add",
        cartData.toJson(),
      );

      print(response["message"]);
    } catch (e) {
      print(e);
      throw ApiError(message: e.toString());
    }
  }

  /// get cart
  Future<ViewCartModel?> getCart() async {
    try {
      final response = await _apiService.getData("/cart");
      return ViewCartModel.fromJson(response);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future   deleteItem(int itemId) async {
    try {
      final response = await _apiService.deleteData("/cart/remove/$itemId", {});

      // print(response);

      return response;
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
