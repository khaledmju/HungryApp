class UserModel {
  final String name;

  final String email;

  final String? image;

  final String? visa;

  final String? address;
  final String? token;

  UserModel({
    required this.name,
    required this.email,
    this.image,
    this.visa,
    this.address,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"] ?? "",
      email: json["email"] ?? "",

      token: json["token"] ?? "",
      image: json["image"] ?? "",
      visa: json["Visa"] ,
      address: json["address"] ?? "",
    );
  }
}
