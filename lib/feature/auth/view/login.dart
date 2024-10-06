
import 'package:ecommerce_app/feature/auth/view/register.dart';
import 'package:ecommerce_app/utils/style/font_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/style/color.dart';
import '../../home/view/home_view.dart';
import '../manager/login/login_cubit.dart';
import '../widget/button_widget.dart';
import '../widget/check_account_text.dart';
import '../widget/text_field_widget.dart';
import '../widget/top_text.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Login Success')),
              );

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeView(),
                ),
              );
            }
            if (state is LoginError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            final cubit = LoginCubit.get(context);

            return Form(
              key: cubit.formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2,),
                    buildTopText(context,
                        title: 'Welcome Back!',
                        subtitle: 'Login to Your Account'),

                    const Spacer(),
                    const SizedBox(height: 50),

                    TextFieldWidget(
                      label: 'Email Address',
                      controller: cubit.emailController,
                      validator: (value) => cubit.validEmail(value),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      hintText: '@gmail.com',

                    ),
                    const SizedBox(height: 20),
                    TextFieldWidget(
                      label: 'Password',
                      controller: cubit.passwordController,
                      validator: (value) => cubit.validPassword(value),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      obsecureText: cubit.isShowLoginPassword,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          cubit.changeLoginPasswordVisibility();
                        },
                        child: Visibility(
                          visible: !cubit.isShowLoginPassword,
                          replacement:  const Icon(CupertinoIcons.eye_slash),
                          child:  const Icon(CupertinoIcons.eye),
                        ),
                      ),
                      hintText: '********',
                    ),
                    const SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerRight,
                        child: InkWell(onTap: (){}, child: Text('Forget Password?',style: AppStyles.styleMedium15(context).copyWith(
                          color: Colors.grey
                        ),),)),
                    const SizedBox(height: 50),
                    if (state is LoginLoading)
                      const CircularProgressIndicator(color: AppColors.blue,),
                    if (state is! LoginLoading)
                      ButtonWidget(
                        loading: false,
                        onPressed: () {
                          cubit.login();
                        },
                        text: 'Sign In',
                        height: 50,
                        decorationColor: Theme.of(context).colorScheme.secondary,
                        hasElevation: true,
                      ),
                    const Spacer(flex: 2,),
                    CheckAccountText(
                      text1: 'New User?',
                      text2: ' Create Account',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Register(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20,)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
