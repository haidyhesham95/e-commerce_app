import 'package:ecommerce_app/core/utils/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/git_it.dart';
import '../../../core/utils/style/color.dart';
import '../../../data/repository/auth_repo_impl.dart';
import '../manager/register/register_cubit.dart';
import '../widget/button_widget.dart';
import '../widget/check_account_text.dart';
import '../widget/text_field_widget.dart';
import '../widget/top_text.dart';
import 'login.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterCubit cubit = RegisterCubit( getIt.get<AuthRepoImpl>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<RegisterCubit, RegisterState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is RegisterSuccess) {
            showToast('Account Created Successfully');
          }
          if (state is RegisterError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) => Form(
          key: cubit.formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  buildTopText(context,
                      title: 'Register Account',
                      subtitle: 'Fill Your Details to Continue'),
                  const SizedBox(height: 50),
                  TextFieldWidget(
                    label: 'Your Name',
                    controller: cubit.nameController,
                    validator: (value) => cubit.validName(value),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'xxxxxxxx',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                    controller: cubit.phoneController,
                    validator: (value) => cubit.validPhone(value),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    label: 'Phone Number',
                    hintText: '01xxxxxxxxx',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                    controller: cubit.emailController,
                    validator: (value) => cubit.validEmail(value),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    hintText: '@gmail.com',
                    label: 'Email Address',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                    controller: cubit.passwordController,
                    validator: (value) => cubit.validPassword(value),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    label: 'Password',
                    hintText: '********',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                    controller: cubit.rePasswordController,
                    validator: (value) => cubit.validRePassword(value),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    label: 'Re-Password',
                    hintText: '********',
                  ),
                  const SizedBox(height: 50),
                  if (state is RegisterLoading)
                    const CircularProgressIndicator(
                      color: AppColors.blue,
                    ),
                  if (state is! RegisterLoading)
                    ButtonWidget(
                      onPressed: () {
                        cubit.register();
                      },
                      loading: false,
                      text: 'Sign Up',
                      height: 50,
                      decorationColor: Theme.of(context).colorScheme.secondary,
                      hasElevation: true,
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  CheckAccountText(
                      text1: 'Already have an account? ',
                      text2: 'Sign In',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginView()));
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
