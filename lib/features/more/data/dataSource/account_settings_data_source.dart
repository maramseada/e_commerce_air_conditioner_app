import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/constant/app_constants.dart';
import '../../../../utilities/shared_pref.dart';

class AccountSettingsApi{
  final dio = Dio();





  Future logout() async {
    const url = '${AppConstants.baseUrl}/api/logout';
    try {

      final token = await getString('token');
      debugPrint('===$token');

      if (token != null) {
        dio.options.headers['Authorization'] = token;
      }

      final response = await dio.post(url);
      debugPrint('================$response');
    } catch (e, stackTrace) {
      debugPrint(' $e $stackTrace');
    }
  }
}