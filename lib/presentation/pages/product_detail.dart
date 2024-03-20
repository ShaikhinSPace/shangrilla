import 'package:ecommerce_app/domain/math.dart';
import 'package:ecommerce_app/domain/productrepo/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductsDetail extends StatefulWidget {
  final ProductModel product;
  const ProductsDetail({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductsDetail> createState() => _ProductsDetailState();
}

class _ProductsDetailState extends State<ProductsDetail> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(_handlePageChange);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handlePageChange() {
    setState(() {
      _currentPage = _pageController.page!.round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 228, 228),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100 - 35,
        backgroundColor: const Color.fromARGB(255, 222, 222, 222),
        title: Center(
          child: Image.asset(
            'assets/banner.png',
            fit: BoxFit.fill,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.white,
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white),
                  alignment: Alignment.topCenter,
                  height: 350,
                  width: MediaQuery.of(context).size.width,
                  child: widget.product.images != null
                      ? PageView.builder(
                          controller: _pageController,
                          itemBuilder: (context, index) {
                            final image = widget.product.images![index];
                            return Image.network(image);
                          },
                          itemCount: widget.product.images!.length,
                        )
                      : Center(
                          child: Text('No images available'),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                      "${_currentPage + 1}/${widget.product.images?.length ?? 0}"),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          widget.product.title ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25 - 5 - 5 + 5),
                        ),
                        Divider(),
                        Row(
                          children: [
                            Text(
                              "\$${calculatePrice((widget.product.discountPercentage)! / 100, widget.product.price).toStringAsFixed(0)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            RichText(
                                text: TextSpan(
                                    text: widget.product.price.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10 + 11 - 1 - 1 - 5,
                                        decoration:
                                            TextDecoration.lineThrough))),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${widget.product.discountPercentage}% off",
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  size: 15,
                                  Icons.star,
                                  color: Color.fromARGB(255, 255, 187, 0),
                                ),
                                Text(
                                  "${widget.product.rating}/5",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            Text(
                              "only ${widget.product.stock} left",
                              style: TextStyle(fontSize: 10),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      shadowColor: MaterialStatePropertyAll(
                          Color.fromARGB(169, 0, 0, 0)),
                      backgroundColor: MaterialStatePropertyAll(Colors.black)),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      Text(
                        'Add to Cart',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
