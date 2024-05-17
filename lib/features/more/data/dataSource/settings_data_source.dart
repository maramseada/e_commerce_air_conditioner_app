import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_commerce/core/constant/app_constants.dart';
import 'package:flutter/cupertino.dart';

import '../../../../models/profileData.dart';
import '../../../../models/social_media.dart';
import '../../../../utilities/shared_pref.dart';
import 'package:http/http.dart' as http;

class SettingsApi{
  final dio = Dio();

  Future socialMedia() async {
    List<SocialMediaModel>? data;
    const url = '${AppConstants.baseUrl}/api/settings/social-urls';
    try {


      final token = await getString('token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await dio.get(url);
      if (response.statusCode == 200 || response.statusCode == 422) {
        final responseData = response.data;
        if (responseData != null) {
          final List<dynamic> productList = responseData["data"];
          data = productList.map((data) => SocialMediaModel.fromJson(data)).toList();
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
    return data;
  }



  Future<Map<String, dynamic>?> changePassword(String firstPassword, String secondPassword, String currentPassword) async {
    try {
      final dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';

      final token = await getString('token');
      debugPrint('Token: $token');

      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await dio.post(
        '${AppConstants.baseUrl}/api/change/password',
        data: {
          'password': firstPassword,
          'password_confirmation': secondPassword,
          'current_password': currentPassword,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to change password: ${response.statusCode} - ${response.data}');
      }
    } catch (e, stackTrace) {
      debugPrint('Error: $e');
      debugPrint('StackTrace: $stackTrace');
      // You can also return a custom error message in the map if needed
      return {'error': e.toString()};
    }
  }
  Future<profileData?> getDataProfile() async {
    profileData? user;
    const url = '${AppConstants.baseUrl}/api/profile';
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
          //  final data = responseData["data"];
          user = profileData.fromJson(response.data["data"]);
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
    return user;
  }

  Future<profileData?> updateAcc(String fName, String lName, String phone) async {
    try {
      Map<String, String> headers = {};
      final dio = Dio();

      const url = '${AppConstants.baseUrl}/api/update/profile';

      final token = await getString('token');
      debugPrint('Token: $token');

      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }

      // Check if at least one field is not empty
      if (fName.isNotEmpty || lName.isNotEmpty || phone.isNotEmpty) {
        Map<String, String> requestBody = {};

        if (fName.isNotEmpty) {
          requestBody['f_name'] = fName;
        }
        if (lName.isNotEmpty) {
          requestBody['l_name'] = lName;
        }
        if (phone.isNotEmpty) {
          requestBody['phone'] = phone;
        }

        final response = await dio.post(
          url,
          data: requestBody,
          options: Options(
            headers: headers // Set the content-length.
            ,
          ),
        );

        if (response.statusCode == 200 || response.statusCode == 422) {
          profileData? data = profileData.fromJson(response.data["data"]);
          return data;
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