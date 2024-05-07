
import 'package:dio/dio.dart';
import 'package:e_commerce/models/ordermodel.dart';
import 'package:flutter/cupertino.dart';
import '../models/fav_model.dart';
import '../models/favourite_product_model.dart';
import '../utilities/shared_pref.dart';

class FavApi {
  final String baseUrl = 'https://albakr-ac.com/api';

  Future<FavModel> favProducts() async { // Change return type to Future<FavModel>
    FavModel data;
    final url = '$baseUrl/favourites';
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
          // Parse JSON response and create FavModel instance
          data = FavModel.fromJson(responseData['data'][0]);
          return data; // Return parsed data
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
  }

  Future isFav(String id ) async { // Change return type to Future<FavModel>
    bool data;
    final url = '$baseUrl/product/details?product_id=$id';
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
          // Parse JSON response and create FavModel instance
          data = responseData['data']['favorite'];
          return data; // Return parsed data
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
  }

  Future<Widget> ImageHome(String image) async {
    final url = 'https://albakr-ac.com/$image'; // Assuming $baseUrl already includes the protocol (http:// or https://)

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
          fit: BoxFit.contain,

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
//
  Future<FavouriteProductModel?> FavProduct(
      int id,
      ) async {
    final url = '$baseUrl/favourite/product';
    FavouriteProductModel? data;
    try {
      final dio = Dio();

      final token = await getString('token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      FormData formData = FormData.fromMap({
        'product_id': id,
      });
      final response = await dio.post(url, data: formData);


      if (response.statusCode == 200 ||response.statusCode == 422 )  {
        final responseData = response.data;
        if (responseData != null) {
          data = FavouriteProductModel.fromJson(responseData['data']);
          return data;
        } }else if (response.statusCode == 422) {
      }
    } catch (e, stackTrace) {
      print('========== Error: $e');
      print('========== Error Stack Trace: $stackTrace');
    }
    return data;
  }
  Future favProduct(
      int id,
      ) async {
    final url = '$baseUrl/favourite/product';
    FavouriteProductModel? data;
    try {
      final dio = Dio();

      final token = await getString('token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      FormData formData = FormData.fromMap({
      'product_id': id,
      });
      final response = await dio.post(url, data: formData);


      if (response.statusCode == 200 ||response.statusCode == 422 )  {
        final responseData = response.data;
        if (responseData != null) {
        data = FavouriteProductModel.fromJson(responseData['data']);
        return data;
      } }else if (response.statusCode == 422) {
      }
    } catch (e, stackTrace) {
      print('========== Error: $e');
      print('========== Error Stack Trace: $stackTrace');
    }
  }
  Future unFavProduct(
      int id,
      ) async {
    final url = '$baseUrl/unFavourite/product';
    try {
      final dio = Dio();

      final token = await getString('token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      FormData formData = FormData.fromMap({
        'product_id': id,
      });
      final response = await dio.post(url, data: formData);

      print('register request response ${response.data}');

      if (response.statusCode == 200 ||response.statusCode == 422 )  {
        final responseData = response.data;
       }
    } catch (e, stackTrace) {
      print('========== Error: $e');
      print('========== Error Stack Trace: $stackTrace');
    }
  }
  Future favAccessory(
      int id,
      ) async {
    final url = '$baseUrl/favourite/accessory';
    Map<String, dynamic> data;
    try {
      final dio = Dio();

      final token = await getString('token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      FormData formData = FormData.fromMap({
        'accessory_id': id,
      });
      final response = await dio.post(url, data: formData);

      print('register request response ${response.data}');

      if (response.statusCode == 200 ||response.statusCode == 422 )  {
        final responseData = response.data;
        if (responseData != null) {
          data = responseData['errors'][0];
          print(data);// Ret*urn parsed data
          return data;
        } }else if (response.statusCode == 422) {
        print("=====dvsgrtef===== ${response.data['errors']['product_id'][0]}");
      }
    } catch (e, stackTrace) {
      print('========== Error: $e');
      print('========== Error Stack Trace: $stackTrace');
    }
  }
  Future unFavAccessory(
      int id,
      ) async {
    final url = '$baseUrl/unFavourite/accessory';
    try {
      final dio = Dio();

      final token = await getString('token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      FormData formData = FormData.fromMap({
        'accessory_id': id,
      });
      final response = await dio.post(url, data: formData);

      print('register request response ${response.data}');

      if (response.statusCode == 200 ||response.statusCode == 422 )  {
        final responseData = response.data;
      }
    } catch (e, stackTrace) {
      print('========== Error: $e');
      print('========== Error Stack Trace: $stackTrace');
    }
  }
}