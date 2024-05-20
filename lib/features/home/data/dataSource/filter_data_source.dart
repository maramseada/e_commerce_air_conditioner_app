import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/constant/app_constants.dart';
import '../../../../models/brandModel.dart';
import '../../../../models/ordermodel.dart';
import '../../../../utilities/shared_pref.dart';
import 'package:http/http.dart' as http;

class FilterDataSource{
  final dio = Dio();


  Future getBrands() async {
    final List<BrandModel> productList = [];
    const url = '${AppConstants.baseUrl}/api/product/brands';

    try {
      final token = await getString('token');

      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await dio.get(url);

      if (response.statusCode == 200 || response.statusCode == 422) {
        final responseData = response.data;

        if (responseData != null && responseData["data"] != null) {
          final List<dynamic> brandList = responseData["data"];
          productList.addAll(brandList.map((data) => BrandModel.fromJson(data)));
        } else {
          throw Exception('Invalid response or missing data field');
        }
      } else {
        throw Exception('Failed to fetch brands (${response.statusCode})');
      }
    } catch (e, stackTrace) {
      debugPrint(' $e $stackTrace');

      throw Exception('Error fetching brands');
    }

    return productList;
  }

  Future<List<ProductsModel>?> filter({
    required String categoryId,
    required List<int> brandsId,
    required String bestseller,
    required String price,
    required String rate,
  }) async {
    try {
      Map<String, String> headers = {};
      const url = '${AppConstants.baseUrl}/api/product/filter';
      debugPrint('categoryId: $categoryId');
      debugPrint('brandsSelected: $brandsId');
      debugPrint('intValueBestSeller: $bestseller');
      debugPrint('selectedOptionPrice: $price');
      debugPrint('selectedOptionRate: $rate');

      final token = await getString('token');
      debugPrint('Token: $token');

      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }

      // Check if at least one field is not empty
      if (categoryId.isNotEmpty || brandsId.isNotEmpty || bestseller.isNotEmpty || rate.isNotEmpty || price.isNotEmpty) {
        Map<String, dynamic> requestBody = {};

        // Parse and add categoryId if not empty
        if (categoryId.isNotEmpty) {
          requestBody['category_id'] = categoryId;
        }
        if (brandsId.isNotEmpty) {
          requestBody['brands_id'] = '$brandsId';
        }
        if (bestseller.isNotEmpty) {
          requestBody['bestseller'] = bestseller;
        }

        if (rate.isNotEmpty) {
          requestBody['rate'] = rate;
        }
        if (price.isNotEmpty) {
          requestBody['price'] = price;
        }
        http.Response response = await http.post(
          Uri.parse(url),
          body: requestBody,
          headers: headers,
        );

        if (response.statusCode == 200 || response.statusCode == 422) {
          final responseData = jsonDecode(response.body);
          if (responseData != null && responseData["data"] != null) {
            // Parse JSON response
            final List<dynamic> productList = responseData["data"];
            List<ProductsModel> products = productList.map((data) => ProductsModel.fromJson(data)).toList();
            return products;
          } else {
            throw Exception('Error: Unexpected status code ${response.statusCode}');
          }
        } else {
          throw Exception('Error: Unexpected status code ${response.statusCode}');
        }
      } else {
        debugPrint('All fields are empty');
        return null;
      }
    } catch (e, stackTrace) {
      debugPrint(' $e $stackTrace');

      throw Exception('An error occurred while updating profile');
    }
  }

}