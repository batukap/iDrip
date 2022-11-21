import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:e_ticaret_app/core/product/model/product_model.dart';
import 'package:get_storage/get_storage.dart';

class ProductService {
  final String baseUrl =
      "https://laravel-test-ecommerce-application.ferisoftdemo.com/api/";
  final dio = Dio();
  List<ProductModel> product = [];

  Future<List<ProductModel?>> productCall() async {
    var token = await GetStorage().read('token');
    var response = await dio.get("${baseUrl}product",
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ));
    if (response.statusCode == 200) {
      var result = jsonDecode(response.data.toString());
      for (Map i in result) {
        product.add(ProductModel.fromJson(i));
      }
      return product;
    } else {
      throw ("Bir sorun oluştu ${response.statusCode}");
    }
  }
}
