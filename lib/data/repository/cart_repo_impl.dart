import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/data/models/cart_model/delete_cart_model.dart';
import 'package:ecommerce_app/domain/core/failure.dart';
import '../../core/api_service.dart';
import '../api/constance.dart';
import '../../core/shared_prefrense_token.dart';
import '../../domain/constracts/repository/cart_repo.dart';
import '../models/cart_model/cart_model.dart';

class CartRepoImpl extends CartRepo {
  final ApiService apiService;

  CartRepoImpl(this.apiService);

  @override
  Future<Either<Failure, CartModel>> getProductCart() async {
    try {
      final token = await SharedPreferenceToken.getToken();

      var response =
          await apiService.get(endPoint: EndPoints.cart, token: token);

      if (response != null && response.isNotEmpty) {
        final cartModel = CartModel.fromJson(response);
        return Right(cartModel);
      } else {
        return left(ServerFailure("Response is null or empty"));
      }
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartModel>> decrementProductToCart(
      String productId, int count) async {
    try {
      final token = await SharedPreferenceToken.getToken();
      var response = await apiService.put(
          endPoint: '${EndPoints.cart}/$productId',
          token: token,
          data: {"count": count});

      if (response != null && response.isNotEmpty) {
        final cartModel = CartModel.fromJson(response);
        return Right(cartModel);
      } else {
        return left(ServerFailure("Response is null or empty"));
      }
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartModel>> incrementProductToCart(
      String productId, int count) async {
    try {
      final token = await SharedPreferenceToken.getToken();
      var response = await apiService.put(
          endPoint: '${EndPoints.cart}/$productId',
          token: token,
          data: {"count": count});

      if (response != null && response.isNotEmpty) {
        final cartModel = CartModel.fromJson(response);
        return Right(cartModel);
      } else {
        return left(ServerFailure("Response is null or empty"));
      }
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartModel>> updateProductCount(
      String productId, int newCount) async {
    try {
      final token = await SharedPreferenceToken.getToken();
      var response = await apiService.put(
          endPoint: '${EndPoints.cart}/$productId',
          token: token,
          data: {"count": newCount});

      if (response != null && response.isNotEmpty) {
        final cartModel = CartModel.fromJson(response);
        return Right(cartModel);
      } else {
        return left(ServerFailure("Response is null or empty"));
      }
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartModel>> deleteProductFromCart(
      String productId) async {
    try {
      final token = await SharedPreferenceToken.getToken();
      var response = await apiService.delete(
          endPoint: '${EndPoints.cart}/$productId',
          token: token,
          data: {
            'productId': productId,
          });

      if (response != null && response.isNotEmpty) {
        final cartModel = CartModel.fromJson(response);
        return Right(cartModel);
      } else {
        return left(ServerFailure("Response is null or empty"));
      }
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeleteCartModel>> clearCart() async {
    try {
      final token = await SharedPreferenceToken.getToken();
      var response = await apiService.delete(
        endPoint: '${EndPoints.cart}',
        token: token,
        data: {},
      );

      if (response != null && response.isNotEmpty) {
        final cartModel = DeleteCartModel.fromJson(response);
        return Right(cartModel);
      } else {
        return left(ServerFailure("Response is null or empty"));
      }
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
