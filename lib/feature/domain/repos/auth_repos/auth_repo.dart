import 'package:dartz/dartz.dart';

import '../../../../utils/error/failure.dart';
import '../../../auth/model/auth_model.dart';

// abstract class AuthRepo {
//
//   login({String email, String password});
//
//  // Future<Either<Failure, AuthModel>> login(String email, String password);
//
// //  Future<Either<Failure, User>> register(String email, String password);
//  // Future<Either<Failure, User>> logout();
// }

abstract class AuthRepo {
  Future<Either<FailureMessage, AuthModel>> login({required String email, required String password});


  Future<Either<FailureMessage, AuthModel>> register({required String name, required String email, required String phone, required String password, required String rePassword});

Future<bool>isAuthenticated();
}