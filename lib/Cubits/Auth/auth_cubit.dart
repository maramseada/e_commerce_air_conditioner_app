import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../api/api.dart';
import '../../models/profileData.dart';
import '../../models/user.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {

  Api api;
  profileData? user;
  AuthCubit(this.api) : super(AuthInitial());

  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  final String baseUrl = 'https://albakr-ac.com/api';














  Future<Map<String, dynamic>?> register(User user,) async {
    emit(RegisterLoading());
    final url = '$baseUrl/register';
    Map<String, dynamic>? data;
    try {
      final dio = Dio();
      FormData formData = FormData.fromMap({

        'email': user.email,

      });
      final response = await dio.post(url, data: formData);

      print('register request response ${response.data}');

      if (response.statusCode == 200) {
        data = response.data;
        emit(RegisterSuccess());
        String token = data?['token'];
        await saveToken(token);

      }
      else {
        print("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      emit(RegisterFailure(errMessage: '$e'));
      print('========== Error: $e');
      print('========== Error Stack Trace: $stackTrace');
    }
    return data;
  }

  Future<Map<String, dynamic>?> login(
      {required String eu, required String password}) async {
    emit(LoginLoading());
    final url = '$baseUrl/login';
    Map<String, dynamic>? data;
    try {
      final dio = Dio();
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };

      final response = await dio.post(url, data: {
        'password': password,
        'email': eu,
      });

      print('login request response ${response.data}');

      if (response.statusCode == 200) {
        data = response.data;
        emit(LoginSuccess());

      } else {
        print("========== ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      emit(LoginFailure(
          errMessage: '$e'
      ));
      print('========== Error: $e');
      print('========== Error Stack Trace: $stackTrace');
    }
    return data;
  }
}