import 'package:dio/dio.dart';
import 'package:ecommerce_app/domain/productrepo/models/product_model.dart';

Future<List<ProductModel>> getData() async {
  try {
    final dio = Dio();
    final response = await dio.get('https://dummyjson.com/products');
    final data = response.data["products"];
    final products = List<ProductModel>.from(
        data.map((product) => ProductModel.fromJson(product)));
    return products;
  } catch (e) {
    print(e);
  }
  return [];
}
