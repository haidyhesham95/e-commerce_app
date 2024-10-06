import 'package:ecommerce_app/feature/home/view/home_view.dart';
import 'package:ecommerce_app/feature/splash_screen.dart';
import 'package:ecommerce_app/utils/git_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'feature/auth/view/login.dart';
import 'feature/data/home_repo/home_repo_impl.dart';
import 'feature/home/manager/home_cubit.dart';

void main() {
  setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(getIt.get<HomeRepoImpl>())
            ..getProducts()
            ..getCategories('')
            ..getBrandProduct(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}


