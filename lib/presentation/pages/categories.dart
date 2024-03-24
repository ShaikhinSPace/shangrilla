import 'package:dio/dio.dart';
import 'package:ecommerce_app/domain/api/callproducts.dart';
import 'package:ecommerce_app/domain/math.dart';
import 'package:ecommerce_app/domain/api/models/product_model.dart';
import 'package:ecommerce_app/presentation/pages/product_detail.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Categories'),
          ),
          SliverToBoxAdapter(
            child: FutureBuilder<List<String>>(
              future: getCategory(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  final categories = snapshot.data!;
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return CatsProducts(
                                  category: category,
                                );
                              }));
                            },
                            child: ListTile(
                              title: Text(
                                category.toString(),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        }),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class CatsProducts extends StatefulWidget {
  final String category;

  const CatsProducts({Key? key, required this.category}) : super(key: key);

  @override
  State<CatsProducts> createState() => _CatsProductsState();
}

class _CatsProductsState extends State<CatsProducts> {
  late Future<List<ProductModel>> _productsFuture;

  @override
  void initState() {
    _productsFuture = getcategoryproData();
    super.initState();
  }

  Future<List<ProductModel>> getcategoryproData() async {
    try {
      final dio = Dio();
      final response = await dio
          .get('https://dummyjson.com/products/category/${widget.category}');
      if (response.statusCode == 200) {
        final data = response.data["products"];
        final products = List<ProductModel>.from(
            data.map((product) => ProductModel.fromJson(product)));
        print("category:::${widget.category}");
        return products;
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          title: Text(widget.category),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder<List<ProductModel>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  final products = snapshot.data!;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductsDetail(product: product),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.white,
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child: Image.network(
                                    product.thumbnail ?? '',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title ?? '',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              size: 15,
                                              color: Color.fromARGB(
                                                  255, 255, 187, 0),
                                            ),
                                            Text(
                                              "${product.rating}/5",
                                              style:
                                                  const TextStyle(fontSize: 10),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "only ${product.stock} left",
                                          style: const TextStyle(fontSize: 10),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "\$${calculatePrice((product.discountPercentage ?? 0) / 100, product.price).toStringAsFixed(0)}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(width: 5),
                                        RichText(
                                          text: TextSpan(
                                            text: product.price.toString(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('No data'),
                  );
                }
              },
            ),
          ),
        )
      ]),
    );
  }
}
