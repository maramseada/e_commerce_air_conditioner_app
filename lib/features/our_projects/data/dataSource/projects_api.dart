import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/constant/app_constants.dart';
import '../models/project.dart';
import '../models/projectsCategory.dart';
import '../../../../utilities/shared_pref.dart';
class ProjectsApi {
  final dio = Dio();


  Future<List<Projects>> projectCategories() async {
    List<Projects> data = [];

    final url = '${AppConstants.baseUrl}/api/project/categories';
    try {


      final token = await getString('token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await dio.get(url);
      if (response.statusCode == 200 ||response.statusCode == 422 )  {
        final responseData = response.data;
        if (responseData != null) {
          data = List<Projects>.from(responseData["data"].map((x) => Projects.fromJson(x)));
        } else {
          throw Exception('Invalid response or status code');
        }
      } else {
        throw Exception('Failed to fetch profile data (${response.statusCode})');
      }
    } catch (e, stackTrace) {
      debugPrint('onCreate -- $e $stackTrace');
      throw Exception('Error fetching profile data');
    }
    return data;
  }


  Future<List<Project>> projectByType({required String id}) async {
    List<Project> data;

    final url = '${AppConstants.baseUrl}/api/project/show?category_id=$id';
    try {

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
      debugPrint('onCreate -- $e $stackTrace');

      throw Exception('Error fetching profile data');
    }
    return data;
  }

}
