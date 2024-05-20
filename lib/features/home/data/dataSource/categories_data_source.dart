
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/constant/app_constants.dart';
import '../../../../models/ordermodel.dart';
import '../../../../utilities/shared_pref.dart';

class CategoriesDataSource{
  final dio = Dio();


  Future getCategories(int id) async {
    List<ProductsModel>? product;
    final url = '${AppConstants.baseUrl}/api/product/category?category_id=$id';
    try {
      final dio = Dio();

      final token = await getString('token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await dio.get(url);
      if (response.statusCode == 200 || response.statusCode == 422) {
        final responseData = response.data;
        if (responseData != null) {
          //  final data = responseData["data"];
          final List<dynamic> productList = responseData["data"]["data"];
          product = productList.map((data) => ProductsModel.fromJson(data)).toList();
        } else {
          throw Exception('Invalid response or status code');
        }
      } else {
        throw Exception('Failed to fetch profile data (${response.statusCode})');
      }
    } catch (e, stackTrace) {
      debugPrint(' $e $stackTrace');

      throw Exception('Error fetching profile data');
    }
    return product;
  }

}