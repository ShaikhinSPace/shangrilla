import 'package:ecommerce_app/presentation/pages/login.dart';
import 'package:ecommerce_app/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const HomeApp());
}

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Lite',
      home: Splash(),
      routes: {'/login': (context) => LoginScreen()},
    );
  }
}
