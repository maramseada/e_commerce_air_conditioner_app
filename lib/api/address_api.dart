
import 'dart:convert';

import 'package:dio/dio.dart';
import '../models/address.dart';
import '../utilities/shared_pref.dart';
import 'package:http/http.dart' as http;

class ApiAddress {
  final String baseUrl = 'https://albakr-ac.com/api';

  Future getArea() async {
    List data;
    final url = '$baseUrl/areas';
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
          //  final data = responseData["data"];
          data = responseData["data"];
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

  Future getCity(int areaId) async {
    List data;
    final url = '$baseUrl/cities/$areaId';
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
          //  final data = responseData["data"];
          data = responseData["data"];
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

  Future getTown(int cityId) async {
    List data;
    final url = '$baseUrl/towns/$cityId';
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
          //  final data = responseData["data"];
          data = responseData["data"];
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

  Future<Map<String, dynamic>?> updateAddress(Address addrress,) async {
    final url = '$baseUrl/update/address';
    dynamic data;
    try {
      final dio = Dio();
      FormData formData = FormData.fromMap({
        'address_id': addrress.id,
        'town_id': addrress.townId,
        'building_num': addrress.buildingNum,
        'street': addrress.street,
        'landmark': addrress.landmark,
      });

      final token = await getString('token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await dio.post(url, data: formData);

      if (response.statusCode == 200 ||response.statusCode == 422 )  {
        data = response.data;
      } else {
        print("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print('========== Error: $e');
      print('========== Error Stack Trace: $stackTrace');
    }
    return data;
  }

  Future addAddress(Address addrress,) async {
    final url = '$baseUrl/add/address';
    dynamic data;
    try {
      final dio = Dio();
      FormData formData = FormData.fromMap({
        'town_id': addrress.townId,
        'building_num': addrress.buildingNum,
        'street': addrress.street,
        'landmark': addrress.landmark,
      });

      final token = await getString('token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await dio.post(url, data: formData);

      if (response.statusCode == 200 ||response.statusCode == 422 )  {
        data = response.data;
      } else {
        print("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print('========== Error: $e');
      print('========== Error Stack Trace: $stackTrace');
    }
    return data;
  }

  Future<dynamic> deleteAddress(String ID) async {
    Map<String, String> headers = {};
    final url = '$baseUrl/delete/address';

    final token = await getString('token');
    print('Token: $token');

    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    http.Response response = await http.post(
      Uri.parse(url),
      body: {'address_id': ID},
      headers: headers,
    );

    if (response.statusCode == 200 ||response.statusCode == 422 )  {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error: ${response.statusCode} - ${response.body}');
    }
  }
}