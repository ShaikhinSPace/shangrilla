import 'package:ecommerce_app/domain/api/callproducts.dart';
import 'package:ecommerce_app/domain/math.dart';
import 'package:ecommerce_app/domain/productrepo/models/product_model.dart';
import 'package:ecommerce_app/presentation/pages/categories.dart';
import 'package:ecommerce_app/presentation/pages/product_detail.dart';
import 'package:flutter/material.dart';

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({super.key});

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const Categories();
                          },
                        ));
                      },
                      child: const Card(
                          elevation: 5,
                          color: Color.fromARGB(255, 218, 218, 218),
                          // margin: EdgeInsets.all(8),
                          // height: 200,
                          // width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.category,
                                  size: 15,
                                ),
                                Text(
                                  'Categories',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      SizedBox(
                        width: 1 + 1 + 1,
                      ),
                      Text(
                        'Products',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                  FutureBuilder<List<ProductModel>>(
                    future: getData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else {
                        final products = snapshot.data ?? [];

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                    style: const TextStyle(
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "only ${product.stock} left",
                                                style: const TextStyle(
                                                    fontSize: 10),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "\$${calculatePrice((product.discountPercentage ?? 0) / 100, product.price).toStringAsFixed(0)}",
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(width: 5),
                                              RichText(
                                                text: TextSpan(
                                                  text:
                                                      product.price.toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10,
                                                    decoration: TextDecoration
                                                        .lineThrough,
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
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
