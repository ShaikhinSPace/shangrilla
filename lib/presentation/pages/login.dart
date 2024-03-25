import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerce_app/domain/api/models/usermodel.dart';
import 'package:ecommerce_app/presentation/widgets/authservice.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController firstNamecon = TextEditingController();
  TextEditingController lastnamecon = TextEditingController();
  TextEditingController gendercon = TextEditingController();
  File? image;

  var id = Uuid().v4().hashCode.abs();
  AuthService authService = AuthService();
  Future<void> onLoginPressed() async {
    UserModel? loggedinUser = await authService.login(
        emailcontroller.text,
        passcontroller.text,
        id,
        firstNamecon.text,
        lastnamecon.text,
        gendercon.text,
        image!.path.toString(),
        Uuid.NAMESPACE_DNS);
    if (loggedinUser != null) {
      print(loggedinUser.email);
    } else {
      print('login fialed');
    }
  }

  Future<void> _pickImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Choose an option'),
          children: [
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
                final pickedImage = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                _setImage(pickedImage);
              },
              child: Text('Camera'),
            ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
                final pickedImage = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                _setImage(pickedImage);
              },
              child: Text('Gallery'),
            ),
          ],
        );
      },
    );
  }

  void _setImage(XFile? pickedImage) {
    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text('Login'),
        ),
        SliverToBoxAdapter(
          child: Card(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: image != null ? FileImage(image!) : null,
                    child: image == null ? Icon(Icons.person) : null,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
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
                TextFormField(
                  controller: firstNamecon,
                  decoration: InputDecoration(label: Text('first name')),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: lastnamecon,
                  decoration: InputDecoration(label: Text('last name')),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: gendercon,
                  decoration: InputDecoration(label: Text('gender')),
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(onPressed: onLoginPressed, child: Text('Login'))
              ],
            ),
          ),
        )
      ],
    ));
  }
}
