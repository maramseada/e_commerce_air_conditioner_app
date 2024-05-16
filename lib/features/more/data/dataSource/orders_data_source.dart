
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_commerce/core/constant/app_constants.dart';
import 'package:flutter/cupertino.dart';

import '../../../../models/ordermodel.dart';
import '../../../../utilities/shared_pref.dart';
import 'package:http/http.dart' as http;

class OrdersApi{

  final dio = Dio();

  Future ordersDetails(int id) async {
    try {
      final dio = Dio();
      final url = '${AppConstants.baseUrl}/api/order/details?order_id=$id';
      final token = await getString('token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await dio.get(url);

      if (response.statusCode == 200 ||response.statusCode == 422 )  {
        final responseData = response.data;

        if (responseData != null && responseData['data'] != null) {
          return OrderModel.fromJson(responseData['data']);
        } else {
          throw Exception('Invalid response data: $responseData');
        }
      } else {
        throw Exception('Failed to fetch orders: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      debugPrint(' $e $stackTrace');
      throw Exception('Error fetching orders');
    }
  }





  Future<List<OrderModel>> ordersCurrent() async {
    try {
      final dio = Dio();
      const url = '${AppConstants.baseUrl}/api/order/current';
      final token = await getString('token');

      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await dio.get(url);

      if (response.statusCode == 200 ||response.statusCode == 422 )  {
        final responseData = response.data;

        if (responseData != null && responseData['errors'] != null) {
          List<dynamic> orderList = responseData['errors'];
          List<OrderModel> orders = orderList.map((data) => OrderModel.fromJson(data)).toList();
          return orders;
        } else {
          throw Exception('Invalid response data: $responseData');
        }
      } else {
        throw Exception('Failed to fetch orders: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      debugPrint(' $e $stackTrace');
      throw Exception('Error fetching orders');
    }
  }
  Future<List<OrderModel>> ordersCompleted() async {
    try {
      const url = '${AppConstants.baseUrl}/api/order/completed';
      final token = await getString('token');

      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await dio.get(url);

      if (response.statusCode == 200 ||response.statusCode == 422 )  {
        final responseData = response.data;

        if (responseData != null && responseData['errors'] != null) {
          List<dynamic> orderList = responseData['errors'];
          List<OrderModel> orders = orderList.map((data) => OrderModel.fromJson(data)).toList();
          return orders;
        } else {
          throw Exception('Invalid response data: $responseData');
        }
      } else {
        throw Exception('Failed to fetch orders: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      debugPrint(' $e $stackTrace');
      throw Exception('Error fetching orders');
    }
  }



  Future<Map<String, dynamic>?> addReview(
      String comment,
      String rate,
      String productId,
      String accessoryId,
      ) async {
    const url = '${AppConstants.baseUrl}/api/review/create';
    Map<String, dynamic>? data;
    try {
      Map<String, String> headers = {};

      final token = await getString('token');
      debugPrint('Token: $token');

      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }
      if (comment.isNotEmpty || rate.isNotEmpty || productId.isNotEmpty ||accessoryId.isNotEmpty) {
        Map<String, String> requestBody = {};

        if (comment.isNotEmpty) {
          requestBody['comment'] = comment;
        }
        if (rate.isNotEmpty) {
          requestBody['rate'] = rate;
        }
        if (productId.isNotEmpty) {
          requestBody['product_id'] = productId;
        }
        if (accessoryId.isNotEmpty) {
          requestBody['accessory_id'] = accessoryId;
        }

        http.Response response = await http.post(Uri.parse(url),
            body: requestBody,
            headers: headers
        );

        debugPrint('Review request response ${response.body}');

        if (response.statusCode == 200 ||response.statusCode == 422 )  {
          data = jsonDecode(response.body);

          debugPrint("Data: $data");
        } else {
          debugPrint("Error: ${response.statusCode}");
        }
      }} catch (e, stackTrace) {
      debugPrint(' $e $stackTrace');
    }
    return data;
  }
}