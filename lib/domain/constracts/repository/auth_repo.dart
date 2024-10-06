import 'package:dartz/dartz.dart';
import '../../../data/models/auth_model/auth_model.dart';
import '../../core/failure.dart';

abstract class AuthRepo {
  Future<Either<FailureMessage, AuthModel>> login({required String email, required String password});
  Future<Either<FailureMessage, AuthModel>> register({required String name, required String email, required String phone, required String password, required String rePassword});
  Future<bool>isAuthenticated();
}