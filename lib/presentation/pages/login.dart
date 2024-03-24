import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:ecommerce_app/domain/api/models/usermodel.dart';
import 'package:ecommerce_app/presentation/widgets/authservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  AuthService authService = AuthService();
  Future<void> onLoginPressed() async {
    UserModel? loggedinUser =
        await authService.login(emailcontroller.text, passcontroller.text);
    if (loggedinUser != null) {
      print(loggedinUser.email);
    } else {
      print('login fialed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Column(
                children: [
                  TextFormField(
                    controller: emailcontroller,
                    decoration: InputDecoration(label: Text('Email')),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: passcontroller,
                    decoration: InputDecoration(label: Text('Password')),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: onLoginPressed, child: Text('Login'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
