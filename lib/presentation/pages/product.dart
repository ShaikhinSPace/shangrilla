import 'package:ecommerce_app/domain/api/callproducts.dart';
import 'package:ecommerce_app/domain/math.dart';
import 'package:ecommerce_app/domain/productrepo/models/product_model.dart';
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
    return FutureBuilder<List<ProductModel>>(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Card(
              child: Text(snapshot.error.toString()),
            ),
          );
        } else {
          final products = snapshot.data!;

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 0.8,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductsDetail(
                                  product: product,
                                )));
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
                                style: TextStyle(fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        size: 15,
                                        Icons.star,
                                        color: Color.fromARGB(255, 255, 187, 0),
                                      ),
                                      Text(
                                        "${product.rating}/5",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "only ${product.stock} left",
                                    style: TextStyle(fontSize: 10),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "\$${calculatePrice((product.discountPercentage)! / 100, product.price).toStringAsFixed(0)}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  RichText(
                                      text: TextSpan(
                                          text: product.price.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                              decoration:
                                                  TextDecoration.lineThrough)))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
