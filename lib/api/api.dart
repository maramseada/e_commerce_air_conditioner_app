import 'dart:convert';
import 'dart:core';
import 'package:dio/dio.dart';
import 'package:e_commerce/models/ordermodel.dart';
import 'package:e_commerce/models/profileData.dart';
import 'package:e_commerce/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../core/constant/app_constants.dart';
import '../models/accessor_model.dart';
import '../models/brandModel.dart';
import '../models/homeModel.dart';
import '../models/settingsModel.dart';
import '../models/social_media.dart';
import '../utilities/shared_pref.dart';

class Api {
  Future<Map<String, dynamic>?> login(String eu, String password) async {
    final url = '${AppConstants.baseUrl}/api/login';
    Map<String, dynamic>? data;
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: {
          'email': eu,
          'password': password,
        },
      );

      debugPrint('login request response ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 422) {
        data = jsonDecode(response.body);
      } else {
        debugPrint("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      debugPrint(' $e $stackTrace');
    }
    return data;
  }


  Future<dynamic> deleteAcc(String email, String password) async {
    Map<String, String> headers = {};
    const url = '${AppConstants.baseUrl}/api/deleteAccount';

    final token = await getString('token');
    debugPrint('===$token');

    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response = await http.post(Uri.parse(url),
        body: {
          'email': email,
          'password': password,
        },
        headers: headers);
    if (response.statusCode == 200 || response.statusCode == 422) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('error data not valid ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }


  Future<Map<String, dynamic>?> resertPassword(
    String email,
    String pass,
    String secPass,
    String otp,
  ) async {
    final url = '${AppConstants.baseUrl}/api/resetPassword';
    Map<String, dynamic>? data;
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: {
          'email': email,
          'password': pass,
          'password_confirmation': secPass,
          'otp': otp,
        },
      );

      debugPrint('register request response ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 422) {
        data = jsonDecode(response.body);
      } else {
        debugPrint("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      debugPrint(' $e $stackTrace');
    }
    return data;
  }


  Future<ProductsModel>? productDetails({required int id}) async {
    ProductsModel? product;
    final url = '${AppConstants.baseUrl}/api/product/details?product_id=$id';
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
          product = ProductsModel.fromJson(response.data["data"]);
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
    return product;
  }

  Future getBestSellers() async {
    List<ProductsModel>? product;
    final url = '${AppConstants.baseUrl}/api/bestseller/products';
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
          final List<dynamic> productList = responseData["data"]["data"];
          product = productList.map((data) => ProductsModel.fromJson(data)).toList();
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
    return product;
  }

  Future getAccessories() async {
    List<AccessoryModel>? product;
    final url = '${AppConstants.baseUrl}/api/bestseller/accessories';
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
          final List<dynamic> productList = responseData["data"]["data"];
          product = productList.map((data) => AccessoryModel.fromJson(data)).toList();
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
    return product;
  }

  Future getCategories(int id) async {
    List<ProductsModel>? product;
    final url = '${AppConstants.baseUrl}/api/product/category?category_id=$id';
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
          final List<dynamic> productList = responseData["data"]["data"];
          product = productList.map((data) => ProductsModel.fromJson(data)).toList();
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
    return product;
  }

//BrandModel
  Future getBrands() async {
    final List<BrandModel> productList = [];
    final url = '${AppConstants.baseUrl}/api/product/brands';

    try {
      final dio = Dio();
      final token = await getString('token');

      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await dio.get(url);

      if (response.statusCode == 200 || response.statusCode == 422) {
        final responseData = response.data;

        if (responseData != null && responseData["data"] != null) {
          final List<dynamic> brandList = responseData["data"];
          productList.addAll(brandList.map((data) => BrandModel.fromJson(data)));
        } else {
          throw Exception('Invalid response or missing data field');
        }
      } else {
        throw Exception('Failed to fetch brands (${response.statusCode})');
      }
    } catch (e, stackTrace) {
      debugPrint(' $e $stackTrace');

      throw Exception('Error fetching brands');
    }

    return productList;
  }

  Future<List<ProductsModel>?> filter(
    String categoryId,
    List<int> brandsId,
    String bestseller,
    String price,
    String rate,
  ) async {
    try {
      Map<String, String> headers = {};
      final url = '${AppConstants.baseUrl}/api/product/filter';
      debugPrint('categoryId: $categoryId');
      debugPrint('brandsSelected: $brandsId');
      debugPrint('intValueBestSeller: $bestseller');
      debugPrint('selectedOptionPrice: $price');
      debugPrint('selectedOptionRate: $rate');

      final token = await getString('token');
      debugPrint('Token: $token');

      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }

      // Check if at least one field is not empty
      if (categoryId.isNotEmpty || brandsId.isNotEmpty || bestseller.isNotEmpty || rate.isNotEmpty || price.isNotEmpty) {
        Map<String, dynamic> requestBody = {};

        // Parse and add categoryId if not empty
        if (categoryId.isNotEmpty) {
          requestBody['category_id'] = categoryId;
        }
        if (brandsId.isNotEmpty) {
          requestBody['brands_id'] = '$brandsId';
        }
        if (bestseller.isNotEmpty) {
          requestBody['bestseller'] = bestseller;
        }

        if (rate.isNotEmpty) {
          requestBody['rate'] = rate;
        }
        if (price.isNotEmpty) {
          requestBody['price'] = price;
        }
        http.Response response = await http.post(
          Uri.parse(url),
          body: requestBody,
          headers: headers,
        );

        if (response.statusCode == 200 || response.statusCode == 422) {
          final responseData = jsonDecode(response.body);
          if (responseData != null && responseData["data"] != null) {
            // Parse JSON response
            final List<dynamic> productList = responseData["data"];
            List<ProductsModel> products = productList.map((data) => ProductsModel.fromJson(data)).toList();
            return products;
          } else {
            throw Exception('Error: Unexpected status code ${response.statusCode}');
          }
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

  Future getSearch(String search) async {
    List<ProductsModel>? product;
    final url = '${AppConstants.baseUrl}/api/product/search?keyword=$search';
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
          final List<dynamic> productList = responseData["data"]["data"];
          product = productList.map((data) => ProductsModel.fromJson(data)).toList();
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
    return product;
  }

  Future<Map<String, dynamic>?> checkOtp(
    String email,
    String otp,
  ) async {
    final url = '${AppConstants.baseUrl}/api/check/otp?email=$email&otp=$otp';
    Map<String, dynamic>? data;
    try {
      final dio = Dio();
      FormData formData = FormData.fromMap({
        'email': email,
      });
      final response = await dio.get(url, data: formData);

      debugPrint('register request response ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 422) {
        data = response.data;
      } else {
        debugPrint("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      debugPrint(' $e $stackTrace');
    }
    return data;
  }

  Future<Map<String, dynamic>?> register(
    String email,
  ) async {
    final url = '${AppConstants.baseUrl}/api/register';
    Map<String, dynamic>? data;
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'email': email,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 422) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        debugPrint("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      debugPrint(' $e $stackTrace');
    }
    return data;
  }

  Future<Map<String, dynamic>?> sendOtp(
    String email,
  ) async {
    final url = '${AppConstants.baseUrl}/api/send/otp?email=$email';
    Map<String, dynamic>? data;
    try {
      final dio = Dio();
      FormData formData = FormData.fromMap({
        'email': email,
      });
      final response = await dio.get(url, data: formData);

      debugPrint('register request response ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 422) {
        data = response.data;
      } else {
        debugPrint("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      debugPrint(' $e $stackTrace');
    }
    return data;
  }

  Future<Map<String, dynamic>?> completeRegister(
    User user,
  ) async {
    final url = '${AppConstants.baseUrl}/api/complete/register';
    Map<String, dynamic>? data;
    try {
      final dio = Dio();
      FormData formData = FormData.fromMap({
        'f_name': user.f_name,
        'l_name': user.l_name,
        'phone': user.phone,
        'password': user.password,
        'password_confirmation': user.password_confirmation,
        'email': user.email,
        'otp': user.otp
      });
      final response = await dio.post(url, data: formData);

      debugPrint('register request response ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 422) {
        data = response.data;
      } else {
        debugPrint("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      debugPrint(' $e $stackTrace');
    }
    return data;
  }

  // Future<Widget> getImage(String image) async {
  //   final url = 'https://albakr-ac.com/$image'; // Assuming ${AppConstants.baseUrl} already includes the protocol (http:// or https://)
  //
  //   try {
  //     final dio = Dio();
  //
  //     final token = await getString('token');
  //     if (token != null) {
  //       dio.options.headers['Authorization'] = 'Bearer $token';
  //     }
  //
  //     final response = await dio.get(url);
  //     if (response.statusCode == 200 ||response.statusCode == 422 )  {
  //       // Use Image.network to load the image from the URL
  //       return Image.network(
  //         url,
  //         fit: BoxFit.cover,
  //         width: double.infinity,
  //       );
  //     } else {
  //       throw Exception('Failed to fetch image data (${response.statusCode})');
  //     }
  //   } catch (e, stackTrace) {
  //    debugPrint('Error fetching image data: $e');
  //    debugPrint(stackTrace);
  //     throw Exception('Error fetching image data');
  //   }
  // }
  // Future<Widget> getImageHome(String image) async {
  //   final url = 'https://albakr-ac.com/$image'; // Assuming ${AppConstants.baseUrl} already includes the protocol (http:// or https://)
  //
  //   try {
  //     final dio = Dio();
  //
  //     final token = await getString('token');
  //     if (token != null) {
  //       dio.options.headers['Authorization'] = 'Bearer $token';
  //     }
  //
  //     final response = await dio.get(url);
  //     if (response.statusCode == 200 ||response.statusCode == 422 )  {
  //       // Use Image.network to load the image from the URL
  //       return Image.network(
  //         url,
  //         height: 70,
  //         fit: BoxFit.fitWidth,
  //       );
  //     } else {
  //       throw Exception('Failed to fetch image data (${response.statusCode})');
  //     }
  //   } catch (e, stackTrace) {
  //    debugPrint('Error fetching image data: $e');
  //    debugPrint(stackTrace);
  //     throw Exception('Error fetching image data');
  //   }
  // }
  // Future<Widget> ImageHome(String image) async {
  //   final url = 'https://albakr-ac.com/$image'; // Assuming ${AppConstants.baseUrl} already includes the protocol (http:// or https://)
  //
  //   try {
  //     final dio = Dio();
  //
  //     final token = await getString('token');
  //     if (token != null) {
  //       dio.options.headers['Authorization'] = 'Bearer $token';
  //     }
  //
  //     final response = await dio.get(url);
  //     if (response.statusCode == 200 ||response.statusCode == 422 )  {
  //       // Use Image.network to load the image from the URL
  //       return Image.network(
  //         url,
  //         fit: BoxFit.contain,
  //         errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
  //           // Handle the error and display an appropriate message or fallback image
  //           return Container();
  //
  //
  //         },
  //       );
  //     } else {
  //       throw Exception('Failed to fetch image data (${response.statusCode})');
  //     }
  //   } catch (e, stackTrace) {
  //    debugPrint('Error fetching image data: $e');
  //    debugPrint(stackTrace);
  //     throw Exception('Error fetching image data');
  //   }
  // }
  Future askPriceCategory() async {
    final url = '${AppConstants.baseUrl}/api/ask_price/categories';
    List? data;
    try {
      final dio = Dio();

      final token = await getString('token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await dio.get(url);

      debugPrint('register request response ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 422) {
        data = response.data["data"];
      } else {
        debugPrint("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      debugPrint(' $e $stackTrace');
    }
    return data;
  }

  Future askPrice(int id, User user, String message) async {
    final url = '${AppConstants.baseUrl}/api/ask_price/store';
    dynamic data;
    try {
      final dio = Dio();
      FormData formData = FormData.fromMap({
        'category_id': id,
        'f_name': user.f_name,
        'l_name': user.l_name,
        'email': user.email,
        'phone': user.phone,
        'message': message,
      });

      final token = await getString('token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await dio.post(url, data: formData);

      if (response.statusCode == 200 || response.statusCode == 422) {
        data = response.data;
      } else {
        debugPrint("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      debugPrint(' $e $stackTrace');
    }
    return data;
  }

  Future Home() async {
    HomeModel? data;
    final url = '${AppConstants.baseUrl}/api/home';
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
          data = HomeModel.fromJson(response.data["data"]);
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

  Future banners() async {
    List<BannerModel>? data;
     const  url = '${AppConstants.baseUrl}/api/home/slider';
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
          final List<dynamic> productList = responseData["data"];
          data = productList.map((data) => BannerModel.fromJson(data)).toList();
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

  Future privacyPolicy() async {
    List<SettingsModel>? data;
    final url = '${AppConstants.baseUrl}/api/settings/privacy_policy';
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
          final List<dynamic> productList = responseData["data"];
          data = productList.map((data) => SettingsModel.fromJson(data)).toList();
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

  Future exchangePolicy() async {
    List<SettingsModel>? data;
    final url = '${AppConstants.baseUrl}/api/settings/privacy_policy';
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
          final List<dynamic> productList = responseData["data"];
          data = productList.map((data) => SettingsModel.fromJson(data)).toList();
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

  Future<AccessoryModel?> accessoryDetails(int id) async {
    AccessoryModel? product;
    final url = '${AppConstants.baseUrl}/api/accessories-details/$id';
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
          product = AccessoryModel.fromJson(response.data["data"]);
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
    return product;
  }



  Future<dynamic> get({required String url}) async {
    Map<String, String> headers = {};

    final dio = Dio();
    final token = await getString('token');
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200 || response.statusCode == 422) {
      return jsonDecode(response.body);
    } else {
      debugPrint('${response.statusCode}');
      throw Exception('error data not valid ${response.statusCode}');
    }
  }

  Future<dynamic> post({required String url, @required dynamic body, @required String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response = await http.post(Uri.parse(url), body: body, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 422) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('error data not valid ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }

  Future<dynamic> put({required String url, @required dynamic body, @required String? token}) async {
    Map<String, String> headers = {};
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response = await http.post(Uri.parse(url), body: body, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 422) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('error data not valid ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }


}
