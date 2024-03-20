import 'package:ecommerce_app/domain/api/getcart.dart';
import 'package:ecommerce_app/domain/productrepo/models/cart_model.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Cart>>(
      future: getCart(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Card(
              child: Text(snapshot.error.toString()),
            ),
          );
        } else {
          final carts = snapshot.data!;
          return ListView.builder(itemBuilder: (context, index) {
            final cart = carts[index];
            return ListTile(
              title: Text(cart.total.toString()),
            );
          });
        }
      },
    );
  }
}
