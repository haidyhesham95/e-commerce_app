import 'package:ecommerce_app/feature/auth/view/login.dart';
import 'package:ecommerce_app/feature/data/auth_repo/auth_repo_impl.dart';
import 'package:ecommerce_app/feature/domain/repos/auth_repos/auth_repo.dart';
import 'package:ecommerce_app/feature/layout/layout_screen.dart';
import 'package:flutter/material.dart';

import 'home/view/home_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), ()async {
      AuthRepo repo = AuthRepoImpl();
      bool isLogin = await repo.isAuthenticated();
      if(isLogin) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  HomeView(),
            )
        );
      }
      else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginView(),
            )
        );
      }

    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(height: 20),
            Text('Splash Screen...'),
          ],
        ),
      ),
    );
  }
}

