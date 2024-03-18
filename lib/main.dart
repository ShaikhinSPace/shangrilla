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

    // print("data::: ${response.extra.entries}");
    final data = response.data['products'];
    setState(() {
      products =
          List.from(data.map((product) => ProductModel.fromJson(product)));
      // print("products ::: ;${products.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              title: Text('e-Commerce'),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // Text(products[index].id.toString()),
                          Text("${products[index].title}"),
                          Image.network(products[index].images!.first)
                        ],
                      ),
                    ),
                  );
                },
                childCount: products.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
