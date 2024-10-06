import 'package:dio/dio.dart';


import 'package:dio/dio.dart';
import 'dart:async';

import 'package:ecommerce_app/utils/shared_prefrense_token.dart';

class ApiService {
  ApiService(this.dio);

  final Dio dio;
  final String baseUrl = "https://ecommerce.routemisr.com/api/v1/";

  Future<String?> refreshToken() async {
    try {
      // Make a POST request to the refresh token endpoint
      var response = await dio.post('$baseUrl/refreshToken');
      if (response.statusCode == 200) {
        String newToken = response.data['token'];

        // Save the new token using SharedPreferences
        await SharedPreferenceToken.saveToken(newToken);
        return newToken;
      } else {
        print('Failed to refresh token: ${response.data}');
        return null; // Return null on failure
      }
    } on DioError catch (e) {
      print('Error refreshing token: ${e.message}');
      // Check for specific error codes if needed
      if (e.response?.statusCode == 400) {
        // Handle bad request, maybe log out the user or prompt for re-login
      }
      return null;
    } catch (e) {
      print('Unexpected error refreshing token: $e');
      return null;
    }
  }


  // General GET request
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
      print('Unexpected error: $e');
      throw Exception('Error occurred during GET request');
    }
  }

  // General POST request with token in header
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

      print('Response: ${response.data}'); // Log the entire response

      // Check if the response is valid before proceeding
      if (response.data == null || response.data.isEmpty) {
        throw Exception('Response is null or missing data');
      }

      return response.data;
    } on DioError catch (e) {
      // Error handling
      print('Error: ${e.message}');
      if (e.response?.data != null) {
        print('Error response data: ${e.response?.data}');
      }
      return _handleDioError(e);
    } catch (e) {
      print('Unexpected error: $e');
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

      print('Response: ${response.data}'); // Log the entire response

      // Check if the response is valid before proceeding
      if (response.data == null || response.data.isEmpty) {
        throw Exception('Response is null or missing data');
      }

      return response.data;
    } on DioError catch (e) {
      // Error handling
      print('Error: ${e.message}');
      if (e.response?.data != null) {
        print('Error response data: ${e.response?.data}');
      }
      return _handleDioError(e);
    } catch (e) {
      print('Unexpected error: $e');
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

      print('Response: ${response.data}'); // Log the entire response

      // Check if the response is valid before proceeding
      if (response.data == null || response.data.isEmpty) {
        throw Exception('Response is null or missing data');
      }

      return response.data;
    } on DioError catch (e) {
      print('Error: ${e.message}');
      if (e.response?.data != null) {
        print('Error response data: ${e.response?.data}');
      }
      return _handleDioError(e);
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Error occurred during POST request');
    }
  }


  // Other methods (PUT, DELETE, etc.) can also handle token refreshing similarly.

  // Handle Dio errors
  Map<String, dynamic> _handleDioError(DioError error) {
    print('DioError: ${error.response?.statusCode} - ${error.message}');
    if (error.response != null) {
      return error.response?.data ?? {'error': 'Unknown error occurred'};
    } else {
      return {'error': 'Network error: ${error.message}'};
    }
  }
}
