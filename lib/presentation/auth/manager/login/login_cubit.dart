import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/api_service.dart';
import '../../../../data/repository/auth_repo_impl.dart';
import '../../../../domain/constracts/repository/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit( this.authRepo) : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  AuthRepo authRepo ;
  bool isShowLoginPassword = true;

  void changeLoginPasswordVisibility() {
    isShowLoginPassword = !isShowLoginPassword;
    emit(ShowPasswordInLogin());
  }

  login() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoading());

      var response = await authRepo.login(
          email: emailController.text,
          password: passwordController.text
      );

      response.fold((failure) {
        emit(LoginError(failure.message));
      }, (authModel) {
        emit(LoginSuccess());
      });
    }
  }






  String? validEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return 'please enter your email';
    }
    var emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (!emailValid) {
      return 'Invalid email address';
    }
    return null;
  }

  String? validPassword(String? password) {
    if (password == null || password.trim().isEmpty) {
      return 'please enter your password';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}




