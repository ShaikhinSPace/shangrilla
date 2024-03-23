import 'package:dio/dio.dart';
import 'package:ecommerce_app/domain/productrepo/models/cart_model.dart';
import 'package:flutter/material.dart';

Future<List<Cart>> getCarts() async {
  try {
    final dio = Dio();
    final response = await dio.get('https://dummyjson.com/carts');
    final data = response.data["carts"];
    final carts = List<Cart>.from(data.map((cart) => Cart.fromJson(cart)));
    return carts;
  } catch (e) {
    Text(e.toString());
  }
  return [];
}
