import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/data/models/cart_model/delete_cart_model.dart';
import '../../../data/models/cart_model/cart_model.dart';
import '../../core/failure.dart';

abstract class CartRepo {
  Future<Either<Failure, CartModel>> getProductCart();

  Future<Either<Failure, CartModel>> decrementProductToCart(
      String productId, int count);

  Future<Either<Failure, CartModel>> incrementProductToCart(
      String productId, int count);

  Future<Either<Failure, CartModel>> updateProductCount(
      String productId, int newCount);

  Future<Either<Failure, CartModel>> deleteProductFromCart(String productId);
  Future<Either<Failure, DeleteCartModel>> clearCart();
}
