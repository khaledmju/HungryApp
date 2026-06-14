class ProductModel {

  final int id;
  final String image;
  final String name;
  final String rate;
  final String desc;
  final String price;


  ProductModel({
    required this.id,
    required this.image,
    required this.name,
    required this.desc,
    required this.rate,
    required this.price,
  });

  factory ProductModel.dummy() {
    return ProductModel(
      id: 0,
      image: "",
      name: "Loading Food Name",
      desc:
          "This is a dummy description placeholder to show skeleton lines nicely.",
      rate: "0.0",
      price: "00.00",
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"] ?? 0,
      image: json["image"] ?? "",
      name: json["name"] ?? "Unknown Product",
      desc: json["description"] ?? "",
      rate: json["rating"] ?? "0.0",
      price: json["price"] ?? "0.00",
    );
  }
}
