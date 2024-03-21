// import 'package:dio/dio.dart';
// import 'package:ecommerce_app/domain/productrepo/models/cart_model.dart';

// Future<List<Cart>> getCart() async {
//   try {
//     final dio = Dio();
//     final response = await dio.get("https://dummyjson.com/carts");
//     final data = response.data["carts"]; // Assuming you want the first cart
//     final carts = List<Cart>.from(data.map((cart) => Cart.fromJson(cart)));
//     return carts;
//   } catch (e) {
//     print(e);
//   }
//   return [];
// }
