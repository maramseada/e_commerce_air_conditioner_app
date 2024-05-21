import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../models/additions_model.dart';
import '../models/address.dart';
import '../models/cart_details_model.dart';
import '../utilities/shared_pref.dart';
import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;


class CartApi{
  final String baseUrl = 'https://albakr-ac.com/api';

  Future  getAdditions()
  async {
    List<AdditionsModel>? data;
    final url = '$baseUrl/additions';
    try {
      final dio = Dio();

      final token = await getString('token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }
      final response = await dio.get(url);
      if (response.statusCode == 200 ||response.statusCode == 422 )  {
        final responseData = response.data;
        if (responseData != null) {
          final List<dynamic> dataAdd = responseData['data'];
          data = dataAdd.map((data) => AdditionsModel.fromJson(data)).toList();
        } else {

          throw Exception('Invalid response or status code');
        }
      } else {
        throw Exception('Failed to fetch profile data (${response.statusCode})');
      }
    } catch (e, stackTrace) {
      print('Error fetching profile data: $e');
      print(stackTrace);
      throw Exception('Error fetching profile data');
    }
    return data;
  }
  Future  getAddresses()
  async {
    List<Address>? data;
    final url = '$baseUrl/addresses';
    try {
      final dio = Dio();

      final token = await getString('token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }
      final response = await dio.get(url);
      if (response.statusCode == 200 ||response.statusCode == 422 )  {
        final responseData = response.data;
        if (responseData != null) {
          final List<dynamic> dataAdd = responseData['data'];
          data = dataAdd.map((data) => Address.fromJson(data)).toList();
        } else {

          throw Exception('Invalid response or status code');
        }
      } else {
        throw Exception('Failed to fetch profile data (${response.statusCode})');
      }
    } catch (e, stackTrace) {
      print('Error fetching profile data: $e');
      print(stackTrace);
      throw Exception('Error fetching profile data');
    }
    return data;
  }
  // add products and accessories
  Future<Map<String, dynamic>?> addProduct({required String itemId, required String quantity,required String addId}) async {
    try {
      Map<String, String> headers = {};
      final url = '$baseUrl/cart/add/product';

      final token = await getString('token');

      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }

      // Check if at least one field is not empty
      if (itemId.isNotEmpty || quantity.isNotEmpty || addId.isNotEmpty) {
        Map<String, dynamic> requestBody = {};

        if (itemId.isNotEmpty) {
          requestBody['product_id'] = itemId;
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
        print('All fields are empty');
        return null;
      }
    } catch (e, stackTrace) {
      // Handle other exceptions
      print('Error: $e');
      print('Stack Trace: $stackTrace');
      throw Exception('An error occurred while updating profile');
    }
  }

  Future<Map<String, dynamic>?>addAccessory({required String itemId,required String quantity}) async {
    try {
      Map<String, String> headers = {};
      final url = '$baseUrl/cart/add/accessory';

      final token = await getString('token');
      print('Token: $token');

      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }



      http.Response response = await http.post(Uri.parse(url),
          body: {
            'accessory_id': itemId,
            'quantity': quantity,
          },
          headers: headers
      );

      if (response.statusCode == 200 ||response.statusCode == 422 ) {
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

  Future<Map<String, dynamic>?> selectAddress(String id) async {
    try {
      Map<String, String> headers = {};
      final url = '$baseUrl/cart/address?address_id=$id';

      final token = await getString('token');
      print('Token: $token');

      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }

      // Check if at least one field is not empty



        http.Response response = await http.get(Uri.parse(url),
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
  Future  getCartDetails()
  async {
    CartData data;
    final url = '$baseUrl/cart/payment';
    try {
      final dio = Dio();

      final token = await getString('token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }
      final response = await dio.get(url);
      if (response.statusCode == 200 ||response.statusCode == 422 )  {
        final responseData = response.data;
        if (responseData != null) {
          data = CartData.fromJson(responseData['data']);
        } else {

          throw Exception('Invalid response or status code');
        }
      } else {
        throw Exception('Failed to fetch profile data (${response.statusCode})');
      }
    } catch (e, stackTrace) {
      print('Error fetching profile data: $e');
      print(stackTrace);
      throw Exception('Error fetching profile data');
    }
    return data;
  }
  Future<CartData?> updateCartDetails(String code) async {
    try {
      final url = '$baseUrl/cart/Updatepayment';
      final dio = Dio();
      Map<String, String> headers = {};

      final token = await getString('token');
      print('Token: $token');

      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }

      final response = await dio.post(
        url,
        data: {'code': code},
        options: Options(headers: headers),
      );

      if (response.statusCode == 200 ||response.statusCode == 422 )  {
        final responseData = response.data; // Get response data directly
        if (responseData != null) {
          return CartData.fromJson(responseData['data']);
        } else {
          throw Exception('Invalid response data');
        }
      } else {
        throw Exception('Failed to update cart (${response.statusCode})');
      }
    } catch (e, stackTrace) {
      print('Error updating cart: $e');
      print(stackTrace);
      throw Exception('Error updating cart. Please try again.');
    }
  }


  // Future<Map<String, dynamic>?> updateProduct(int itemId, int quantity, int addId) async {
  //   final url = '$baseUrl/cart/update/product';
  //   Map<String, dynamic>? data;
  //   try {
  //     final dio = Dio();
  //     Map<String, String> headers = {};
  //
  //     final token = await getString('token');
  //     print('Token: $token');
  //
  //     if (token != null) {
  //       headers.addAll({'Authorization': 'Bearer $token'});
  //     }
  //     final formData = FormData.fromMap({
  //       'item_id': itemId.toString(),
  //       'quantity': quantity.toString(),
  //       'add_id': addId.toString(),
  //     });
  //     http.Response response = await http.post(Uri.parse(url),
  //         body: requestBody,
  //         headers: headers
  //     );
  //
  //     print('Update product request response ${response.data}');
  //
  //     if (response.statusCode == 200 ||response.statusCode == 422 )  {
  //       data = response.data['data'];
  //       print('Data received: $data');
  //     } else {
  //       print('Failed with status code: ${response.statusCode}');
  //     }
  //   } catch (e, stackTrace) {
  //     print('Error: $e');
  //     print('Error Stack Trace: $stackTrace');
  //   }
  //   return data;
  // }



}