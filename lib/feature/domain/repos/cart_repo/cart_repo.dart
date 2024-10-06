import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/feature/cart/model/cart_model.dart';
import 'package:ecommerce_app/feature/cart/model/get_cart.dart';

import '../../../../utils/error/failure.dart';
import '../../../home/model/add_cart.dart';

abstract class  CartRepo {
  Future<Either<Failure, CartModel>> getProductCart();

  Future<Either<Failure, CartModel>> decrementProductToCart(String productId,
      int count);

  Future<Either<Failure, CartModel>> incrementProductToCart(String productId,
      int count);

  Future<Either<Failure, CartModel>> updateProductCount(String productId, int newCount);

  Future<Either<Failure, CartModel>> deleteProductFromCart(String productId);
}