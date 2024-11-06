import 'package:ecommerce_app/core/git_it.dart';
import 'package:ecommerce_app/data/api/constance.dart';
import 'package:ecommerce_app/data/repository/home_repo_impl.dart';
import 'package:ecommerce_app/presentation/home/manager/home_cubit.dart';
import 'package:ecommerce_app/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';


void main() {

  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey=EndPoints.publishableKey;

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


