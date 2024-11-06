import 'package:dio/dio.dart';
import 'dart:async';
import 'package:ecommerce_app/core/shared_prefrense_token.dart';

class ApiService {
  ApiService(this.dio);

  final Dio dio;
  final String baseUrl = "https://ecommerce.routemisr.com/api/v1/";

  Future<String?> refreshToken() async {
    try {
      var response = await dio.post('$baseUrl/refreshToken');
      if (response.statusCode == 200) {
        String newToken = response.data['token'];

        await SharedPreferenceToken.saveToken(newToken);
        return newToken;
      } else {
        print('Failed to refresh token: ${response.data}');
        return null;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
      }
      return null;
    } catch (e) {
      return null;
    }
  }


  Future<Map<String, dynamic>> get({required String endPoint ,  String? token}) async {
    try {
      var response = await dio.get('$baseUrl$endPoint',
          options: Options(
            headers: {
              'token': token,
            },
          ));
      return response.data;
    } on DioError catch (e) {
      return _handleDioError(e);
    } catch (e) {
      throw Exception('Error occurred during GET request');
    }
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    required Map<String, dynamic> data,
    required String? token,
  }) async {
    try {
      var response = await dio.post(
        '$baseUrl$endPoint',
        data: data,
        options: Options(
          headers: {
            'token': token,
          },
        ),
      );

      print('Response: ${response.data}');

      if (response.data == null || response.data.isEmpty) {
        throw Exception('Response is null or missing data');
      }

      return response.data;
    } on DioError catch (e) {
      if (e.response?.data != null) {
      }
      return _handleDioError(e);
    } catch (e) {
      throw Exception('Error occurred during POST request');
    }
  }

  Future<Map<String, dynamic>> put({
    required String endPoint,
    required Map<String, dynamic> data,
    required String? token,
  }) async {
    try {
      var response = await dio.put(
        '$baseUrl$endPoint',
        data: data,
        options: Options(
          headers: {
            'token': token,

          },

        ),

      );

      print('Response: ${response.data}');

      if (response.data == null || response.data.isEmpty) {
        throw Exception('Response is null or missing data');
      }

      return response.data;
    } on DioError catch (e) {
      if (e.response?.data != null) {
      }
      return _handleDioError(e);
    } catch (e) {
      throw Exception('Error occurred during POST request');
    }
  }


  Future<Map<String, dynamic>> delete({
    required String endPoint,
    required String? token,
    required Map<String, dynamic> data,
  }) async {
    try {
      var response = await dio.delete(
        '$baseUrl$endPoint',
        data: data,
        options: Options(
          headers: {
            'token': token,
          },
        ),
      );


      if (response.data == null || response.data.isEmpty) {
        throw Exception('Response is null or missing data');
      }

      return response.data;
    } on DioError catch (e) {
      if (e.response?.data != null) {
      }
      return _handleDioError(e);
    } catch (e) {
      throw Exception('Error occurred during POST request');
    }
  }


  Map<String, dynamic> _handleDioError(DioError error) {
    if (error.response != null) {
      return error.response?.data ?? {'error': 'Unknown error occurred'};
    } else {
      return {'error': 'Network error: ${error.message}'};
    }
  }


  }
