import 'dart:core';
import 'package:dio/dio.dart';
import 'package:e_commerce/models/ordermodel.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/constant/app_constants.dart';
import '../../../../models/accessor_model.dart';
import '../../../../models/homeModel.dart';
import '../../../../utilities/shared_pref.dart';
import 'package:flutter/material.dart';


class HomeDataSource {
  final Dio _dio;

  HomeDataSource() : _dio = Dio();

  Future<void> _setAuthToken() async {
    final token = await getString('token');
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  Future<List<ProductsModel>?> getSearch(String search) async {
    final url = '${AppConstants.baseUrl}/api/product/search?keyword=$search';
    return _fetchProductList(url);
  }

  Future<List<ProductsModel>?> getBestSellers() async {
    const url = '${AppConstants.baseUrl}/api/bestseller/products';
    return _fetchProductList(url);
  }

  Future<List<AccessoryModel>?> getAccessories() async {
    const url = '${AppConstants.baseUrl}/api/bestseller/accessories';
    return _fetchAccessoryList(url);
  }

  Future<HomeModel?> getHomeData() async {
    const url = '${AppConstants.baseUrl}/api/home';
    await _setAuthToken();
    return _fetchData<HomeModel>(url, (data) => HomeModel.fromJson(data));
  }

  Future<List<BannerModel>?> getBanners() async {
    const url = '${AppConstants.baseUrl}/api/home/slider';
    return _fetchBannerList(url);
  }

  Future<List<ProductsModel>?> _fetchProductList(String url) async {
    await _setAuthToken();
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200 || response.statusCode == 422) {
        final List<dynamic> productList = response.data["data"]["data"];
        return productList.map((data) => ProductsModel.fromJson(data)).toList();
      } else {
        throw Exception('Failed to fetch product data (${response.statusCode})');
      }
    } catch (e, stackTrace) {
      debugPrint('Error fetching product data: $e\n$stackTrace');
      throw Exception('Error fetching product data');
    }
  }

  Future<List<AccessoryModel>?> _fetchAccessoryList(String url) async {
    await _setAuthToken();
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200 || response.statusCode == 422) {
        final List<dynamic> productList = response.data["data"]["data"];
        return productList.map((data) => AccessoryModel.fromJson(data)).toList();
      } else {
        throw Exception('Failed to fetch accessory data (${response.statusCode})');
      }
    } catch (e, stackTrace) {
      debugPrint('Error fetching accessory data: $e\n$stackTrace');
      throw Exception('Error fetching accessory data');
    }
  }

  Future<List<BannerModel>?> _fetchBannerList(String url) async {
    await _setAuthToken();
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200 || response.statusCode == 422) {
        final List<dynamic> bannerList = response.data["data"];
        return bannerList.map((data) => BannerModel.fromJson(data)).toList();
      } else {
        throw Exception('Failed to fetch banner data (${response.statusCode})');
      }
    } catch (e, stackTrace) {
      debugPrint('Error fetching banner data: $e\n$stackTrace');
      throw Exception('Error fetching banner data');
    }
  }

  Future<T?> _fetchData<T>(String url, T Function(Map<String, dynamic>) fromJson) async {
    await _setAuthToken();
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200 || response.statusCode == 422) {
        final responseData = response.data["data"];
        return fromJson(responseData);
      } else {
        throw Exception('Failed to fetch data (${response.statusCode})');
      }
    } catch (e, stackTrace) {
      debugPrint('Error fetching data: $e\n$stackTrace');
      throw Exception('Error fetching data');
    }
  }
}
