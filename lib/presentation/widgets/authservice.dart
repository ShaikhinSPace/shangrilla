import 'package:dio/dio.dart';
import 'package:ecommerce_app/domain/api/models/usermodel.dart';
import 'package:uuid/uuid.dart';

class AuthService {
  final Dio dio = Dio();
  Future<UserModel?> login(
      String email,
      String password,
      int id,
      String firstname,
      String lastname,
      String gender,
      String image,
      String token) async {
    try {
      final response = await dio.post('https://dummyjson.com/auth/login',
          data: {
            'id': id,
            'email': email,
            'password': password,
            'firstName': firstname,
            'lastName': lastname,
            'gender': gender,
            'image': image,
            'token': token
          },
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ));

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
