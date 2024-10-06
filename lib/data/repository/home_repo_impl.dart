import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/domain/core/failure.dart';

import '../../core/api_service.dart';
import '../api/constance.dart';
import '../../core/shared_prefrense_token.dart';
import '../models/auth_model/auth_model.dart';
import '../models/home_model/add_cart.dart';
import '../models/home_model/add_wishlist.dart';
import '../models/home_model/brand_model.dart';
import '../models/home_model/categories_model.dart';
import '../models/home_model/product_model.dart';
import '../../domain/constracts/repository/home_repo.dart';


class HomeRepoImpl extends HomeRepo {
  final ApiService apiService;

  HomeRepoImpl(this.apiService);



  @override
  Future<Either<Failure, List<CategoriesModel>>> getCategories( String id) async {
    try {
      var data = await apiService.get(endPoint: EndPoints.categories);

      var categoriesList = data['data'] as List<dynamic>;
      var categories = categoriesList.map((category) =>
          CategoriesModel.fromJson(category as Map<String, dynamic>)).toList();
      return Right(categories);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }





  @override
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
      var response = await apiService.get(endPoint: EndPoints.products);

      var productsList = response['data'] as List<dynamic>;
      var products = productsList.map((product) => ProductModel.fromJson(product as Map<String, dynamic>)).toList();
      return Right(products);


    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, AddProductToCart>> addProductToCart(String productId) async {
    try {
      String? token = await SharedPreferenceToken.getToken();
      print('Token: $token');

      var response = await apiService.post(
        endPoint: EndPoints.cart,
        data: {
          'productId': productId,
        },
        token: token,
      );

      print('Response: $response');

      if (response == null || response['data'] == null) {
        return Left(ServerFailure('Response is null or missing data'));
      }

      if (response['status'] == "success") {
        var cart = AddProductToCart.fromJson(response['data']);
        return Right(cart);
      } else if (response['status'] == 401 || response['message'] == "Token expired") {
        print('Token expired, refreshing token...');
        await refreshAuthToken();
        return addProductToCart(productId);
      } else {
        return Left(ServerFailure(response['message'] ?? 'Unexpected server error'));
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 401) {
          print('Error: Token expired');
          return Left(ExpiredTokenFailure( e.response?.data['message'] ?? 'Token expired'));
        } else {
          print('DioError: ${e.response?.statusCode}');
          return Left(ServerFailure.fromDiorError(e));
        }
      } else {
        print('Unexpected Error: $e');
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  Future<void> refreshAuthToken() async {
    var newToken = await apiService.refreshToken();
    await SharedPreferenceToken.saveToken(newToken!);
    print('Token refreshed successfully');
  }



  @override
  Future<Either<Failure, AuthModel>> logout() async {
    await SharedPreferenceToken.removeToken();
    await SharedPreferenceToken.removeUser();
    print('Token removed successfully');
    return Right(AuthModel());
  }

  @override
  Future<Either<Failure, List<Brand>>> brandProduct() async {
    try {
      var response = await apiService.get(endPoint: EndPoints.brand);
      var brandList = response['data'] as List<dynamic>;
      var brands = brandList.map((brand) => Brand.fromJson(brand as Map<String, dynamic>)).toList();
      return Right(brands);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<WishlistResponse>>> addProductToWishList(String productId) async {
    try {
      String? token = await SharedPreferenceToken.getToken();
      print('Token: $token');

     var response = await apiService.post(
          endPoint: EndPoints.wishlist,
          data: {
            'productId': productId,
          },
          token: token
      );
      if (response['data'] != null && response['data'] is List) {
        var wishlistResponse = List<String>.from(response['data']);
        return Right(wishlistResponse.cast<WishlistResponse>());
      } else {
        return left(ServerFailure('Unexpected response structure'));
      }
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<WishlistResponse>>> removeProductFromWishList(String productId) async {
    try {
      String? token = await SharedPreferenceToken.getToken();
      print('Token: $token');

      var response = await apiService.delete(
          data:
          {
            'productId': productId,
          },
          endPoint: '${EndPoints.wishlist}/$productId',
          token: token
      );

      if (response['data'] != null && response['data'] is List) {
        var wishlistResponse = List<String>.from(response['data']);
        return Right(wishlistResponse.cast<WishlistResponse>());
      } else {
        return left(ServerFailure('Unexpected response structure'));
      }
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

}