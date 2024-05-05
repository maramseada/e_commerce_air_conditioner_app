import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:e_commerce/models/profileData.dart';
import 'package:e_commerce/models/user.dart';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/address.dart';
import '../utilities/shared_pref.dart';

class WorksApi {
  final String baseUrl = 'https://albakr-ac.com';
  Future workCategories() async {
    Map<String, dynamic> data;

    final url = '$baseUrl/api/works';
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
  Future workByType(String type) async {
    List data;

    final url = '$baseUrl/api/works/show?type=$type';
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
///
  Future<Widget> getImage(String image) async {
    final url = '$baseUrl/$image'; // Assuming $baseUrl already includes the protocol (http:// or https://)

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

// https://albakr-ac.com/mid/images/10.png
}
