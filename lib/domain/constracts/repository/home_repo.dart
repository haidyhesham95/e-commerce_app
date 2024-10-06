import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/domain/core/failure.dart';
import '../../../data/models/auth_model/auth_model.dart';
import '../../../data/models/home_model/add_cart.dart';
import '../../../data/models/home_model/add_wishlist.dart';
import '../../../data/models/home_model/brand_model.dart';
import '../../../data/models/home_model/categories_model.dart';
import '../../../data/models/home_model/product_model.dart';


abstract class HomeRepo {
  Future<Either<Failure, AuthModel>> logout();

  Future<Either<Failure, List<CategoriesModel>>> getCategories(String id);

  Future<Either<Failure, List<ProductModel>>> getProducts();

  Future<Either<Failure, AddProductToCart>> addProductToCart(String productId);

  Future<Either<Failure, List<Brand>>> brandProduct();

  Future<Either<Failure, List<WishlistResponse>>> addProductToWishList(
      String productId);

  Future<Either<Failure, List<WishlistResponse>>> removeProductFromWishList(
      String productId);
}
