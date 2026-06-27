import 'package:hungry/features/product/data/toppings_model.dart';

// to backend
class CartModel {
  final int productId;
  final int quantity;
  final double spicy;
  final List<int> toppings;
  final List<int> sideOptions;

  CartModel({
    required this.productId,
    required this.quantity,
    required this.spicy,
    required this.sideOptions,
    required this.toppings,
  });

  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
      "quantity": quantity,
      "spicy": spicy,
      "toppings": toppings,
      "side_options": sideOptions,
    };
  }
}

class CartRequestModel {
  final List<CartModel> items;

  CartRequestModel({required this.items});

  Map<String, dynamic> toJson() {
    return {"items": items.map((e) => e.toJson()).toList()};
  }
}

// from backend

class ViewCartModel {
  final int code;

  final String message;

  final CartData cartData;

  ViewCartModel({
    required this.code,
    required this.message,
    required this.cartData,
  });

  factory ViewCartModel.fromJson(Map<String, dynamic> json) {
    return ViewCartModel(
      code: json["code"],
      message: json["message"],
      cartData: CartData.fromJson(json["data"]),
    );
  }
}

class CartData {
  final int id;

  final String totalPrice;

  final List<ItemsCart> items;

  CartData({required this.id, required this.totalPrice, required this.items});

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      id: json["id"],
      totalPrice: json["total_price"],
      items: (json["items"] as List).map((e) => ItemsCart.fromJson(e)).toList(),
    );
  }
}

class ItemsCart {
  final int itemId;

  final int productId;

  final String name;

  final String image;

  final int quantity;

  final String price;

  final double spicy;

  final List<ToppingsModel> toppings;

  final List<ToppingsModel> sideOptions;

  ItemsCart({
    required this.itemId,
    required this.productId,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
    required this.spicy,
    required this.toppings,
    required this.sideOptions,
  });

  factory ItemsCart.fromJson(Map<String, dynamic> json) {
    return ItemsCart(
      itemId: json["item_id"],
      productId: json["product_id"],
      name: json["name"],
      image: json["image"],
      quantity: json["quantity"],
      price: json["price"],
      spicy: double.parse(json["spicy"].toString()),
      toppings: (json["toppings"] as List)
          .map((e) => ToppingsModel.fromJson(e))
          .toList(),
      sideOptions: (json["side_options"] as List)
          .map((e) => ToppingsModel.fromJson(e))
          .toList(),
    );
  }
}
