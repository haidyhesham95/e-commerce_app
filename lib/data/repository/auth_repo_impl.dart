import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import '../../core/api_service.dart';
import '../api/constance.dart';
import '../models/auth_model/auth_model.dart';
import '../../domain/core/failure.dart';
import '../../core/shared_prefrense_token.dart';
import '../../domain/constracts/repository/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final ApiService apiService;

  AuthRepoImpl(this.apiService);


  @override
  @override
  Future<Either<FailureMessage, AuthModel>> login({required String email, required String password}) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return Left(FailureMessage(message: connectiveMessage));
    }

    try {
      final response = await apiService.post(
        endPoint: EndPoints.login,
        data: {
          'email': email,
          'password': password,
        },
        token: null,
      );

      if (response['message'] == 'success') {
        var authModel = AuthModel.fromJson(response);

        if (authModel.token != null && authModel.user != null) {
          await SharedPreferenceToken.saveToken(authModel.token!);
          await SharedPreferenceToken.saveUser(authModel.user!);
        }
        return Right(authModel);
      } else {
        return Left(FailureMessage(message: response['message']));
      }
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
      final response = await apiService.post(
        endPoint: EndPoints.register,
        data: {
          'email': email,
          'name': name,
          'phone': phone,
          'rePassword': rePassword,
          'password': password,
        },
        token: null,
      );

      if (response['message'] == 'success') {
        var authModel = AuthModel.fromJson(response);

        if (authModel.token != null && authModel.user != null) {
          await SharedPreferenceToken.saveToken(authModel.token!);
          await SharedPreferenceToken.saveUser(authModel.user!);
        }

        return Right(authModel);
      } else {
        return Left(FailureMessage(message: response['message']));
      }
    } catch (e) {
      return Left(FailureMessage(message: 'An unexpected error occurred: ${e.toString()}'));
    }
  }



              @override
  Future<bool> isAuthenticated() async {
    final user = await SharedPreferenceToken.getUser();
    final token = await SharedPreferenceToken.getToken();

    return user != null && token != null;
  }
}
