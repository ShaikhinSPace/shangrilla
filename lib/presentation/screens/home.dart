import 'package:ecommerce_app/domain/api/callproducts.dart';
import 'package:ecommerce_app/domain/productrepo/models/product_model.dart';
import 'package:ecommerce_app/presentation/pages/product.dart';
import 'package:ecommerce_app/presentation/screens/account.dart';
import 'package:ecommerce_app/presentation/screens/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> products = [];
  int _currentIndex = 0;

  @override
  void initState() {
    getData().then((value) {
      setState(() {
        products = value;
      });
    });
    super.initState();
  }

  void onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      AllProductsPage(),
      CartScreen(),
      AccountScreen()
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100 - 35,
        backgroundColor: const Color.fromARGB(255, 222, 222, 222),
        title: Center(
            child: Image.asset(
          'assets/banner.png',
          fit: BoxFit.fill,
        )),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Account'), // Add a label here
        ],
      ),
    );
  }
}
