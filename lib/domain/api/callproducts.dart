import 'package:dio/dio.dart';
import 'package:ecommerce_app/domain/productrepo/models/product_model.dart';
import 'package:flutter/material.dart';

Future<List<ProductModel>> getData() async {
  try {
    final dio = Dio();
    final response = await dio.get('https://dummyjson.com/products');
    final data = response.data["products"];
    final products = List<ProductModel>.from(
        data.map((product) => ProductModel.fromJson(product)));
    return products;
  } catch (e) {
    Text(e.toString());
  }
  return [];
}

Future<List<String>> getCategory() async {
  try {
    final dio = Dio();
    final response = await dio.get('https://dummyjson.com/products/categories');
    if (response.statusCode == 200) {
      // Print the response data for debugging
      print(response.data);

      // Assuming the response data is a list of strings, return it
      List<String> categories = List<String>.from(response.data);
      return categories;
    } else {
      // Handle unexpected status code
      print('Failed to load categories. Status code: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    // Handle any other errors
    print('Error loading categories: $e');
    return [];
  }
}
