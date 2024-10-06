import 'package:dio/dio.dart';
import 'package:ecommerce_app/data/repository/auth_repo_impl.dart';
import 'package:get_it/get_it.dart';
import '../data/repository/cart_repo_impl.dart';
import '../data/repository/home_repo_impl.dart';
import '../data/repository/wishlist_repo_impl.dart';
import 'api_service.dart';


final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(
    ApiService(
      Dio(),
    ),
  );

  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      getIt.get<ApiService>(),
    ),
  );
  getIt.registerSingleton<CartRepoImpl>(
    CartRepoImpl(
      getIt.get<ApiService>(),
    )
  );
  getIt.registerSingleton<WishlistRepoImpl>(
    WishlistRepoImpl(
      getIt.get<ApiService>(),
    )
  );
  getIt.registerSingleton<AuthRepoImpl>(
    AuthRepoImpl(
      getIt.get<ApiService>(),
    ),
    );



}