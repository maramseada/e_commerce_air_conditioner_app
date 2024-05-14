import 'package:dio/dio.dart';
import 'package:e_commerce/core/constant/app_constants.dart';
import 'package:flutter/cupertino.dart';

import '../../../../models/social_media.dart';
import '../../../../utilities/shared_pref.dart';

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
}