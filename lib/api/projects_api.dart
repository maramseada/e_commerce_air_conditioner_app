import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:e_commerce/models/profileData.dart';
import 'package:e_commerce/models/user.dart';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/address.dart';
import '../models/project.dart';
import '../models/projectsCategory.dart';
import '../utilities/shared_pref.dart';
class ProjectsApi {
  final String baseUrl = 'https://albakr-ac.com';
  Future<List<Projects>> projectCategories() async {
    List<Projects> data = [];

    final url = '$baseUrl/api/project/categories';
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
          // Parse the JSON data into a list of Projects
          data = List<Projects>.from(responseData["data"].map((x) => Projects.fromJson(x)));
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
  Future<List<Project>> projectByType(String id) async {
    List<Project> data;

    final url = '$baseUrl/api/project/show?category_id=$id';
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
          data = (responseData["data"] as List<dynamic>).map((item) => Project.fromJson(item)).toList();
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
