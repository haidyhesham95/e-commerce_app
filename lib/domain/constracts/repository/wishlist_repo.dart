import 'package:dartz/dartz.dart';
import '../../../data/models/home_model/add_wishlist.dart';
import '../../../data/models/wishlist_model/wishlist_model.dart';
import '../../core/failure.dart';


abstract class  WishlistRepo{
  Future<Either<Failure, WishlistModel>> getWishlist();
  Future<Either<Failure, List<WishlistResponse>>> removeProductFromWishList(String productId);

}