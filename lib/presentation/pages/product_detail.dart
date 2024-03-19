import 'package:ecommerce_app/domain/productrepo/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductsDetail extends StatefulWidget {
  final ProductModel product;
  const ProductsDetail({super.key, required this.product});

  @override
  State<ProductsDetail> createState() => _ProductsDetailState();
}

class _ProductsDetailState extends State<ProductsDetail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [Text(widget.product.price.toString())],
        ),
      ),
    );
  }
}
