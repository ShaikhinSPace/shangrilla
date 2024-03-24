import 'dart:convert';

class CartModel {
  int? id;
  List<Product>? products;
  int? total;
  int? discountedTotal;
  int? userId;
  int? totalProducts;
  int? totalQuantity;

  CartModel({
    this.id,
    this.products,
    this.total,
    this.discountedTotal,
    this.userId,
    this.totalProducts,
    this.totalQuantity,
  });

  CartModel copyWith({
    int? id,
    List<Product>? products,
    int? total,
    int? discountedTotal,
    int? userId,
    int? totalProducts,
    int? totalQuantity,
  }) =>
      CartModel(
        id: id ?? this.id,
        products: products ?? this.products,
        total: total ?? this.total,
        discountedTotal: discountedTotal ?? this.discountedTotal,
        userId: userId ?? this.userId,
        totalProducts: totalProducts ?? this.totalProducts,
        totalQuantity: totalQuantity ?? this.totalQuantity,
      );

  factory CartModel.fromRawJson(String str) =>
      CartModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        total: json["total"],
        discountedTotal: json["discountedTotal"],
        userId: json["userId"],
        totalProducts: json["totalProducts"],
        totalQuantity: json["totalQuantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
        "total": total,
        "discountedTotal": discountedTotal,
        "userId": userId,
        "totalProducts": totalProducts,
        "totalQuantity": totalQuantity,
      };
}

class Product {
  int? id;
  String? title;
  int? price;
  int? quantity;
  int? total;
  double? discountPercentage;
  int? discountedPrice;
  String? thumbnail;

  Product({
    this.id,
    this.title,
    this.price,
    this.quantity,
    this.total,
    this.discountPercentage,
    this.discountedPrice,
    this.thumbnail,
  });

  Product copyWith({
    int? id,
    String? title,
    int? price,
    int? quantity,
    int? total,
    double? discountPercentage,
    int? discountedPrice,
    String? thumbnail,
  }) =>
      Product(
        id: id ?? this.id,
        title: title ?? this.title,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        total: total ?? this.total,
        discountPercentage: discountPercentage ?? this.discountPercentage,
        discountedPrice: discountedPrice ?? this.discountedPrice,
        thumbnail: thumbnail ?? this.thumbnail,
      );

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        quantity: json["quantity"],
        total: json["total"],
        discountPercentage: json["discountPercentage"].toDouble(),
        discountedPrice: json["discountedPrice"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "quantity": quantity,
        "total": total,
        "discountPercentage": discountPercentage,
        "discountedPrice": discountedPrice,
        "thumbnail": thumbnail,
      };
}
