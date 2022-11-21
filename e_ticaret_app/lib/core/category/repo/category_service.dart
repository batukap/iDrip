import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:e_ticaret_app/core/category/model/category_model.dart';
import 'package:get_storage/get_storage.dart';

class CategoryService {
  final String baseUrl =
      "https://laravel-test-ecommerce-application.ferisoftdemo.com/api/";
  final dio = Dio();
  List<CategoryModel> category = [];

  Future<List<CategoryModel?>> categoryCall() async {
    var token = await GetStorage().read('token');
    var response = await dio.get("${baseUrl}category",
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ));
    if (response.statusCode == 200) {
      var result = jsonDecode(response.data.toString());
      for (Map i in result) {
        category.add(CategoryModel.fromJson(i));
      }

      return category;
    } else {
      throw ("Bir sorun oluştu ${response.statusCode}");
    }
  }
}
