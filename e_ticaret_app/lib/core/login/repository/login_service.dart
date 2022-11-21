import 'package:dio/dio.dart';
import 'package:e_ticaret_app/core/login/model/login_model.dart';

class LoginService {
  final String baseUrl =
      "https://laravel-test-ecommerce-application.ferisoftdemo.com/api/";
  final dio = Dio();

  Future<LoginModel?> loginCall(
      {required String email, required String password}) async {
    Map<String, dynamic> json = {"email": email, "password": password};
    var response = await dio.post("${baseUrl}login", data: json);
    if (response.statusCode == 200) {
      return LoginModel.fromJson(response.data);
    } else {
      return null;
      //throw ("Bir sorun oluştu ${response.statusCode}");
    }
  }
}
