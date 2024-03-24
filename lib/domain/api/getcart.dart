import 'package:dio/dio.dart';
import 'package:ecommerce_app/domain/api/models/cart_model.dart';
import 'package:flutter/material.dart';

Future<List<CartModel>> getCarts() async {
  try {
    final dio = Dio();
    final response = await dio.get('https://dummyjson.com/carts');
    final data = response.data["carts"];
    final carts =
        List<CartModel>.from(data.map((cart) => CartModel.fromJson(cart)));
    return carts;
  } catch (e) {
    Text(e.toString());
  }
  return [];
}
