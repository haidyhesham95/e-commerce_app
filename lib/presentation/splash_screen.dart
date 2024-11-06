import 'package:ecommerce_app/core/git_it.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../data/repository/auth_repo_impl.dart';
import '../generated/assets.dart';
import 'auth/view/login.dart';
import 'home/view/home_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 6), () async {
      final repo = getIt<AuthRepoImpl>();
      bool isLogin = await repo.isAuthenticated();

      if (isLogin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginView(),
          ),
        );
      }
    });

    return  Scaffold(
      body: Lottie.asset(Assets.imagesSplash, fit: BoxFit.fill,
        height: double.infinity,
        width: double.infinity,

      ),
    );
  }
}

