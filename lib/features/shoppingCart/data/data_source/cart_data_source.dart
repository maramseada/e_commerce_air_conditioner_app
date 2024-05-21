import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_commerce/core/constant/app_constants.dart';
import 'package:flutter/cupertino.dart';

import '../../../../models/cart_model.dart';
import '../../../../utilities/shared_pref.dart';
import 'package:http/http.dart' as http;

class CartDataSource{

  final dio = Dio();

  Future  getCart()
  async {
    CartModel data;
    const url = '${AppConstants.baseUrl}/api/cart';
    try {

      final token = await getString('token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }
      final response = await dio.get(url);
      if (response.statusCode == 200 ||response.statusCode == 422 )  {
        final responseData = response.data;
        if (responseData != null) {
          data = CartModel.fromJson(responseData['data']);
        } else {

          throw Exception('Invalid response or status code');
        }
      } else {
        throw Exception('Failed to fetch profile data (${response.statusCode})');
      }
    } catch (e, stackTrace) {
      debugPrint('Error fetching profile data: $e');
      debugPrint('$stackTrace');
      throw Exception('Error fetching profile data');
    }
    return data;
  }
  Future<Map<String, dynamic>?> updateProduct({required String itemId, required String quantity, required String addId}) async {
    try {
      Map<String, String> headers = {};
      const url = '${AppConstants.baseUrl}/api/cart/update/product';

      final token = await getString('token');
      debugPrint('Token: $token');

      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }

      // Check if at least one field is not empty
      if (itemId.isNotEmpty || quantity.isNotEmpty || addId.isNotEmpty) {
        Map<String, dynamic> requestBody = {};

        if (itemId.isNotEmpty) {
          requestBody['item_id'] = itemId;
        }
        if (quantity.isNotEmpty) {
          requestBody['quantity'] = quantity;
        }
        if (addId.isNotEmpty) {
          requestBody['add_id'] = addId;
        }

        http.Response response = await http.post(Uri.parse(url),
            body: requestBody,
            headers: headers
        );

        if (response.statusCode == 200 ||response.statusCode == 422 )  {
          // Parse JSON response
          Map<String, dynamic> data = jsonDecode(response.body);
          return data;
        } else {
          throw Exception('Error: Unexpected status code ${response.statusCode}');
        }
      } else {
        debugPrint('All fields are empty');
        return null;
      }
    } catch (e, stackTrace) {
      // Handle other exceptions
      debugPrint('Error: $e');
      debugPrint('Stack Trace: $stackTrace');
      throw Exception('An error occurred while updating profile');
    }
  }
  Future<Map<String, dynamic>?> updateAccessory({required String itemId,required String quantity}) async {
    try {
      Map<String, String> headers = {};
      const url = '${AppConstants.baseUrl}/api/cart/update/accessory';

      final token = await getString('token');
      print('Token: $token');

      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }



      http.Response response = await http.post(Uri.parse(url),
          body: {
            'item_id': itemId,
            'quantity': quantity,
          },
          headers: headers
      );

      if (response.statusCode == 200 ||response.statusCode == 422 )  {
        // Parse JSON response
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Error: Unexpected status code ${response.statusCode}');
      }

    } catch (e, stackTrace) {
      // Handle other exceptions
      print('Error: $e');
      print('Stack Trace: $stackTrace');
      throw Exception('An error occurred while updating profile');
    }
  }

}