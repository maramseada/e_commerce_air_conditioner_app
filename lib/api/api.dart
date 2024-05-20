import 'dart:convert';
import 'dart:core';
import 'package:dio/dio.dart';
import 'package:e_commerce/models/ordermodel.dart';
import 'package:e_commerce/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../core/constant/app_constants.dart';
import '../models/accessor_model.dart';
import '../models/homeModel.dart';
import '../utilities/shared_pref.dart';

class Api {
  Future<Map<String, dynamic>?> login(String eu, String password) async {
    final url = '${AppConstants.baseUrl}/api/login';
    Map<String, dynamic>? data;
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: {
          'email': eu,
          'password': password,
        },
      );

      debugPrint('login request response ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 422) {
        data = jsonDecode(response.body);
      } else {
        debugPrint("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      debugPrint(' $e $stackTrace');
    }
    return data;
  }


  Future<dynamic> deleteAcc(String email, String password) async {
    Map<String, String> headers = {};
    const url = '${AppConstants.baseUrl}/api/deleteAccount';

    final token = await getString('token');
    debugPrint('===$token');

    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response = await http.post(Uri.parse(url),
        body: {
          'email': email,
          'password': password,
        },
        headers: headers);
    if (response.statusCode == 200 || response.statusCode == 422) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('error data not valid ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }


  Future<Map<String, dynamic>?> resertPassword(
    String email,
    String pass,
    String secPass,
    String otp,
  ) async {
    final url = '${AppConstants.baseUrl}/api/resetPassword';
    Map<String, dynamic>? data;
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: {
          'email': email,
          'password': pass,
          'password_confirmation': secPass,
          'otp': otp,
        },
      );

      debugPrint('register request response ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 422) {
        data = jsonDecode(response.body);
      } else {
        debugPrint("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      debugPrint(' $e $stackTrace');
    }
    return data;
  }


  Future<ProductsModel>? productDetails({required int id}) async {
    ProductsModel? product;
    final url = '${AppConstants.baseUrl}/api/product/details?product_id=$id';
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
          product = ProductsModel.fromJson(response.data["data"]);
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



//BrandModel


  Future<Map<String, dynamic>?> checkOtp(
    String email,
    String otp,
  ) async {
    final url = '${AppConstants.baseUrl}/api/check/otp?email=$email&otp=$otp';
    Map<String, dynamic>? data;
    try {
      final dio = Dio();
      FormData formData = FormData.fromMap({
        'email': email,
      });
      final response = await dio.get(url, data: formData);

      debugPrint('register request response ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 422) {
        data = response.data;
      } else {
        debugPrint("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      debugPrint(' $e $stackTrace');
    }
    return data;
  }

  Future<Map<String, dynamic>?> register(
    String email,
  ) async {
    final url = '${AppConstants.baseUrl}/api/register';
    Map<String, dynamic>? data;
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'email': email,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 422) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        debugPrint("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      debugPrint(' $e $stackTrace');
    }
    return data;
  }

  Future<Map<String, dynamic>?> sendOtp(
    String email,
  ) async {
    final url = '${AppConstants.baseUrl}/api/send/otp?email=$email';
    Map<String, dynamic>? data;
    try {
      final dio = Dio();
      FormData formData = FormData.fromMap({
        'email': email,
      });
      final response = await dio.get(url, data: formData);

      debugPrint('register request response ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 422) {
        data = response.data;
      } else {
        debugPrint("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      debugPrint(' $e $stackTrace');
    }
    return data;
  }

  Future<Map<String, dynamic>?> completeRegister(
    User user,
  ) async {
    final url = '${AppConstants.baseUrl}/api/complete/register';
    Map<String, dynamic>? data;
    try {
      final dio = Dio();
      FormData formData = FormData.fromMap({
        'f_name': user.f_name,
        'l_name': user.l_name,
        'phone': user.phone,
        'password': user.password,
        'password_confirmation': user.password_confirmation,
        'email': user.email,
        'otp': user.otp
      });
      final response = await dio.post(url, data: formData);

      debugPrint('register request response ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 422) {
        data = response.data;
      } else {
        debugPrint("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      debugPrint(' $e $stackTrace');
    }
    return data;
  }
  Future askPriceCategory() async {
    final url = '${AppConstants.baseUrl}/api/ask_price/categories';
    List? data;
    try {
      final dio = Dio();

      final token = await getString('token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await dio.get(url);

      debugPrint('register request response ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 422) {
        data = response.data["data"];
      } else {
        debugPrint("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      debugPrint(' $e $stackTrace');
    }
    return data;
  }

  Future askPrice(int id, User user, String message) async {
    final url = '${AppConstants.baseUrl}/api/ask_price/store';
    dynamic data;
    try {
      final dio = Dio();
      FormData formData = FormData.fromMap({
        'category_id': id,
        'f_name': user.f_name,
        'l_name': user.l_name,
        'email': user.email,
        'phone': user.phone,
        'message': message,
      });

      final token = await getString('token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await dio.post(url, data: formData);

      if (response.statusCode == 200 || response.statusCode == 422) {
        data = response.data;
      } else {
        debugPrint("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      debugPrint(' $e $stackTrace');
    }
    return data;
  }



  Future<AccessoryModel?> accessoryDetails(int id) async {
    AccessoryModel? product;
    final url = '${AppConstants.baseUrl}/api/accessories-details/$id';
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
          product = AccessoryModel.fromJson(response.data["data"]);
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



  Future<dynamic> get({required String url}) async {
    Map<String, String> headers = {};

    final dio = Dio();
    final token = await getString('token');
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200 || response.statusCode == 422) {
      return jsonDecode(response.body);
    } else {
      debugPrint('${response.statusCode}');
      throw Exception('error data not valid ${response.statusCode}');
    }
  }

  Future<dynamic> post({required String url, @required dynamic body, @required String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response = await http.post(Uri.parse(url), body: body, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 422) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('error data not valid ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }

  Future<dynamic> put({required String url, @required dynamic body, @required String? token}) async {
    Map<String, String> headers = {};
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response = await http.post(Uri.parse(url), body: body, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 422) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('error data not valid ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }


}
