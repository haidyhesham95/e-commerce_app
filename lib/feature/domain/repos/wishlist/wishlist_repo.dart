import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/feature/wishlist/model/wishlist_model.dart';

import '../../../../utils/error/failure.dart';
import '../../../home/model/add_wishlist.dart';

abstract class  WishlistRepo{
  Future<Either<Failure, WishlistModel>> getWishlist();
  Future<Either<Failure, List<WishlistResponse>>> removeProductFromWishList(String productId);

}