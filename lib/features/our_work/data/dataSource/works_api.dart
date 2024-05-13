import 'package:dio/dio.dart';
import '../../../../constant/app_constants.dart';
import '../../../../utilities/shared_pref.dart';
import '../models/works.dart';

class WorksApi {
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
  Future workByType({required String type}) async {
    List<Works> data;

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
          data = (responseData["data"] as List<dynamic>).map((item) => Works.fromJson(item)).toList();

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

}
