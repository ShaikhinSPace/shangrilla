import 'package:dio/dio.dart';
import 'package:ecommerce_app/domain/api/models/usermodel.dart';

class AuthService {
  final Dio dio = Dio();
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await dio.post('https://dummyjson.com/auth/login',
          data: {'email': email, 'password': password});
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
