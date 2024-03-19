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
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            alignment: Alignment.topCenter,
            height: 500,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: [Text(widget.product.title ?? '')],
              ),
            ),
          )
        ],
      ),
    );
  }
}
