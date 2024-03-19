import 'package:ecommerce_app/domain/api/callproducts.dart';
import 'package:ecommerce_app/domain/productrepo/models/product_model.dart';
import 'package:ecommerce_app/presentation/pages/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> products = [];

  @override
  void initState() {
    getData().then((value) {
      setState(() {
        products = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 222, 222, 222),
          title: Center(child: Image.asset('assets/banner.png')),
        ),
        body: AllProductsPage());
  }
}
