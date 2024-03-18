import 'package:ecommerce_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const HomeApp());
}

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  // Map<String, dynamic> jsondata = {};
  List<ProductModel> products = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final dio = Dio();
    final response = await dio.get('https://dummyjson.com/products');

    print("data == ${response.data}");
    final data = response.data['products'];
    setState(() {
      products =
          List.from(data.map((product) => ProductModel.fromJson(product)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Test"),
        ),
        body: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(16)),
          height: 600,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (context, index) {
              List<ProductModel> product = products;
              // ProductModel test = products[index];
              // Map<String, dynamic> test = products;

              return Column(
                children: [Text("${product[index].title}")],
              );
            },
          ),
        ),
      ),
    );
  }
}
