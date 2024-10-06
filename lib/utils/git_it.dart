import 'package:dio/dio.dart';
import 'package:ecommerce_app/feature/data/cart_repo/cart_repo_impl.dart';
import 'package:get_it/get_it.dart';
import '../feature/data/home_repo/home_repo_impl.dart';
import '../feature/data/wishlist_repo/wishlist_repo_impl.dart';
import '../utils/api_service.dart';


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



}