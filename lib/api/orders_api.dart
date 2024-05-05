import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:e_commerce/models/ordermodel.dart';
import 'dart:convert';
import 'dart:core';
import '../utilities/shared_pref.dart';

import 'package:flutter/cupertino.dart';

class OrdersApi{

  final String baseUrl = 'https://albakr-ac.com';
//current
  Future<Widget> getImage(String image) async {
    final url = 'https://albakr-ac.com/$image'; // Assuming $baseUrl already includes the protocol (http:// or https://)

    try {
      final dio = Dio();

      final token = await getString('token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await dio.get(url);
      if (response.statusCode == 200 ||response.statusCode == 422 )  {
        // Use Image.network to load the image from the URL
        return Image.network(
          url,
          fit: BoxFit.cover,
          width: double.infinity,
        );
      } else {
        throw Exception('Failed to fetch image data (${response.statusCode})');
      }
    } catch (e, stackTrace) {
      print('Error fetching image data: $e');
      print(stackTrace);
      throw Exception('Error fetching image data');
    }
  }
  Future<Widget> getImageHome(String image) async {
    final url = 'https://albakr-ac.com/$image'; // Assuming $baseUrl already includes the protocol (http:// or https://)

    try {
      final dio = Dio();

      final token = await getString('token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await dio.get(url);
      if (response.statusCode == 200 ||response.statusCode == 422 )  {
        // Use Image.network to load the image from the URL
        return Image.network(
          url,
          height: 70,
          fit: BoxFit.fitWidth,
        );
      } else {
        throw Exception('Failed to fetch image data (${response.statusCode})');
      }
    } catch (e, stackTrace) {
      print('Error fetching image data: $e');
      print(stackTrace);
      throw Exception('Error fetching image data');
    }
  }
  Future<Widget> ImageHome(String image) async {
    final url = 'https://albakr-ac.com/$image'; // Assuming $baseUrl already includes the protocol (http:// or https://)

    try {
      final dio = Dio();

      final token = await getString('token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await dio.get(url);
      if (response.statusCode == 200 ||response.statusCode == 422 )  {
        // Use Image.network to load the image from the URL
        return Image.network(
          url,
          fit: BoxFit.contain,
          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
            // Handle the error and display an appropriate message or fallback image
            return Container();


          },
        );
      } else {
        throw Exception('Failed to fetch image data (${response.statusCode})');
      }
    } catch (e, stackTrace) {
      print('Error fetching image data: $e');
      print(stackTrace);
      throw Exception('Error fetching image data');
    }
  }
  Future<OrderModel?> ordersDetails(int id) async {
    try {
      final dio = Dio();
      final url = '$baseUrl/api/order/details?order_id=$id';
      final token = await getString('token');
print(token);
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
      print('Error fetching orders: $e');
      print(stackTrace);
      throw Exception('Error fetching orders');
    }
  }





  Future<List<OrderModel>> ordersCurrent() async {
    try {
      final dio = Dio();
      final url = '$baseUrl/api/order/current';
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
      print('Error fetching orders: $e');
      print(stackTrace);
      throw Exception('Error fetching orders');
    }
  }
  Future<List<OrderModel>> ordersCompleted() async {
    try {
      final dio = Dio();
      final url = '$baseUrl/api/order/completed';
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
      print('Error fetching orders: $e');
      print(stackTrace);
      throw Exception('Error fetching orders');
    }
  }



  Future<Map<String, dynamic>?> addReview(
      String comment,
      String rate,
      String productId,
      String accessoryId,
      ) async {
    final url = '$baseUrl/api/review/create';
    Map<String, dynamic>? data;
    try {
      Map<String, String> headers = {};

    final token = await getString('token');
      print('Token: $token');

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

      print('Review request response ${response.body}');

      if (response.statusCode == 200 ||response.statusCode == 422 )  {
        data = jsonDecode(response.body);

        print("Data: $data");
      } else {
        print("Error: ${response.statusCode}");
      }
    }} catch (e, stackTrace) {
      print('Error: $e');
      print('Error Stack Trace: $stackTrace');
    }
    return data;
  }
}