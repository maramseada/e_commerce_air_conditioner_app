
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../../../models/address.dart';
import '../../../../models/places.dart';
import '../../../../utilities/shared_pref.dart';
import 'package:http/http.dart' as http;

class ApiAddress {
  final String baseUrl = 'https://albakr-ac.com/api';

  Future <List<Places>> getArea() async {
    List<Places> data;
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
          final List<dynamic> productList = responseData["data"];
          data = productList.map((data) => Places.fromJson(data)).toList();
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

  Future  <List<Places>> getCity(int areaId) async {
    List<Places> data;
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
          final List<dynamic> productList = responseData["data"];
          data = productList.map((data) => Places.fromJson(data)).toList();
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

  Future <List<Places>> getTown(int cityId) async {
    List<Places> data;    final url = '$baseUrl/towns/$cityId';
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
          final List<dynamic> productList = responseData["data"];
          data = productList.map((data) => Places.fromJson(data)).toList();        } else {
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

  Future<Map<String, dynamic>?> updateAddress({required
    Address address,
  }) async {
    final url = '$baseUrl/update/address';
    dynamic data;
    try {
      final dio = Dio();
      FormData formData = FormData.fromMap({
        'address_id': address.id,
        'town_id': address.townId,
        'building_num': address.buildingNum,
        'street': address.street,
        'landmark': address.landmark,
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

  Future addAddress({required Address address}) async {
    final url = '$baseUrl/add/address';
    dynamic data;
    try {
      final dio = Dio();
      FormData formData = FormData.fromMap({
        'town_id': address.townId,
        'building_num': address.buildingNum,
        'street': address.street,
        'landmark': address.landmark,
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
print (ID);
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
//
// class ApiAddress {
//   final String baseUrl = 'https://albakr-ac.com/api';
//   final Dio dio = Dio();
//   Future getArea() async {
//     final url = '$baseUrl/areas';
//     return await _getData(url);
//   }
//
//   Future getCity(int areaId) async {
//     final url = '$baseUrl/cities/$areaId';
//     return await _getData(url);
//   }
//
//   Future getTown(int cityId) async {
//     final url = '$baseUrl/towns/$cityId';
//     return await _getData(url);
//   }
//
//
//
//   Future<Map<String, dynamic>?> updateAddress(Address address) async {
//     final url = '$baseUrl/update/address';
//     FormData formData = FormData.fromMap({
//       'address_id': address.id,
//       'town_id': address.townId,
//       'building_num': address.buildingNum,
//       'street': address.street,
//       'landmark': address.landmark,
//     });
//
//     return await _postData(url, formData);
//   }
//
//   Future<Map<String, dynamic>?> addAddress(Address address) async {
//     final url = '$baseUrl/add/address';
//     FormData formData = FormData.fromMap({
//       'town_id': address.townId,
//       'building_num': address.buildingNum,
//       'street': address.street,
//       'landmark': address.landmark,
//     });
//
//     return await _postData(url, formData);
//   }
//
//   Future<dynamic> deleteAddress(String id) async {
//     final url = '$baseUrl/delete/address';
//     final token = await getString('token');
//     final headers = {'Authorization': 'Bearer $token'};
//
//     final response = await http.post(
//       Uri.parse(url),
//       body: {'address_id': id},
//       headers: headers,
//     );
//
//     if (response.statusCode == 200 || response.statusCode == 422) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Error: ${response.statusCode} - ${response.body}');
//     }
//   }
//   Future<List<dynamic>> _getData(String url) async {
//     try {
//       final token = await getString('token');
//       if (token != null) {
//         dio.options.headers['Authorization'] = 'Bearer $token';
//       }
//
//       final response = await dio.get(url);
//       if (response.statusCode == 200 || response.statusCode == 422) {
//         final responseData = response.data;
//         if (responseData != null && responseData["data"] != null) {
//           return responseData["data"];
//         } else {
//           throw Exception('Invalid response or status code');
//         }
//       } else {
//         throw Exception('Failed to fetch data (${response.statusCode})');
//       }
//     } catch (e, stackTrace) {
//       debugPrint('Error: $e');
//       debugPrint('Error Stack Trace: $stackTrace');
//       throw Exception('Error fetching data');
//     }
//   }
//   Future<Map<String, dynamic>?> _postData(String url, FormData formData) async {
//     try {
//       final token = await getString('token');
//       if (token != null) {
//         dio.options.headers['Authorization'] = 'Bearer $token';
//       }
//
//       final response = await dio.post(url, data: formData);
//
//       if (response.statusCode == 200 || response.statusCode == 422) {
//         return response.data;
//       } else {
//         debugPrint("Error: ${response.statusCode}");
//       }
//     } catch (e, stackTrace) {
//       debugPrint('Error: $e');
//       debugPrint('Error Stack Trace: $stackTrace');
//     }
//     return null;
//   }
//
//  }