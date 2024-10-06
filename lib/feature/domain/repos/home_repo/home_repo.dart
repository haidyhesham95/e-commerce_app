import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/feature/cart/model/cart_model.dart';
import 'package:ecommerce_app/feature/home/model/add_cart.dart';
import 'package:ecommerce_app/feature/home/model/add_wishlist.dart';
import 'package:ecommerce_app/feature/home/model/brand_model.dart';
import 'package:ecommerce_app/feature/home/model/categories_model.dart';
import 'package:ecommerce_app/feature/home/model/product_model.dart';
import 'package:ecommerce_app/utils/error/failure.dart';

import '../../../auth/model/auth_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, AuthModel>> logout();

  Future<Either<Failure, List<CategoriesModel>>> getCategories( String id);
  Future<Either<Failure, List<ProductModel>>> getProducts();
  Future<Either<Failure, AddProductToCart>> addProductToCart( String productId);
  Future<Either<Failure, List<Brand>>> brandProduct();
  Future<Either<Failure, List<WishlistResponse>>> addProductToWishList(String productId);
  Future<Either<Failure, List<WishlistResponse>>> removeProductFromWishList(String productId);

 // Future<Either<Failure, List<ProductModel>>> searchProducts(String query);

}