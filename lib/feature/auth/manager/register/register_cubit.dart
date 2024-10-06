import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/auth_repo/auth_repo_impl.dart';
import '../../../domain/repos/auth_repos/auth_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  AuthRepo authRepo = AuthRepoImpl();

   TextEditingController nameController = TextEditingController();
   TextEditingController emailController = TextEditingController();
   TextEditingController phoneController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

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


  String? validRePassword(String? rePassword) {
    if (rePassword == null || rePassword.trim().isEmpty) {
      return 'please enter your password';
    }
    if (rePassword != passwordController.text) {
      return 'Password does not match';
    }
    return null;
  }

  String? validName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return 'please enter your name';
    }
    return null;
  }

  String? validPhone(String? phone) {
    if (phone == null || phone.trim().isEmpty) {
      return 'please enter your phone number';
    }
    return null;
  }


  void register() async {
    if (formKey.currentState!.validate()) {
      emit(RegisterLoading());

      var response = await authRepo.register(
          name: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
          password: passwordController.text,
          rePassword: passwordController.text
      );

      response.fold((failure) {
        emit(RegisterError(failure.message));
      }, (authModel) {
        emit(RegisterSuccess());
      });
    }
  }
}
