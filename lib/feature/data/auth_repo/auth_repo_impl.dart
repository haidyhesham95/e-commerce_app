import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../utils/constance.dart';
import '../../../../utils/error/failure.dart';
import '../../../utils/shared_prefrense_token.dart';
import '../../auth/model/auth_model.dart';
import '../../domain/repos/auth_repos/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final Dio dio = Dio();

  @override
  Future<Either<FailureMessage, AuthModel>> login({required String email, required String password}) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return Left(FailureMessage(message: connectiveMessage));
    }

    try {
      final response = await dio.post(
        '$baseUrl${EndPoints.login}',
        data: {
          'email': email,
          'password': password,
        },
      );

      // Check response status code
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        var data = response.data;
        var authModel = AuthModel.fromJson(data);

        if (authModel.user != null && authModel.token != null) {
          await SharedPreferenceToken.saveUser(authModel.user!);

          await SharedPreferenceToken.saveToken(authModel.token!);

          // Log the saved token for debugging
          final savedToken = await SharedPreferenceToken.getToken();
          print('Token saved successfully: $savedToken');

          return Right(authModel);
        } else {
          return Left(FailureMessage(message: 'Invalid login response: missing user or token.'));
        }
      } else {
        var errorMessage = response.data['message'] ?? 'An error occurred';
        return Left(FailureMessage(message: errorMessage));
      }
    } on DioException catch (e) {
      var errorMessage = e.response?.data['message'] ?? 'An unexpected error occurred: ${e.message}';
      return Left(FailureMessage(message: errorMessage));
    } catch (e) {
      return Left(FailureMessage(message: 'An unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Either<FailureMessage, AuthModel>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String rePassword,
  }) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return Left(FailureMessage(message: connectiveMessage));
    }

    try {
      final response = await dio.post(
        '$baseUrl${EndPoints.register}',
        data: {
          'email': email,
          'name': name,
          'phone': phone,
          'rePassword': rePassword,
          'password': password,
        },
      );

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        var data = response.data;
        var authModel = AuthModel.fromJson(data);

        if (authModel.user != null && authModel.token != null) {
          await SharedPreferenceToken.saveUser(authModel.user!);
          await SharedPreferenceToken.saveToken(authModel.token!);
        }

        return Right(authModel);
      } else {
        var errorMessage = response.data['message'] ?? 'An error occurred';
        return Left(FailureMessage(message: errorMessage));
      }
    } on DioException catch (e) {
      var errorMessage = e.response?.data['message'] == 'fail'
          ? e.response?.data['errors']['msg']
          : e.response?.data['message'] ?? 'An unexpected error occurred: ${e.message}';
      return Left(FailureMessage(message: errorMessage));
    } catch (e) {
      return Left(FailureMessage(message: 'An unexpected error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    final user = await SharedPreferenceToken.getUser();
    final token = await SharedPreferenceToken.getToken();

    // Check if both user and token are available
    return user != null && token != null;
  }
}
