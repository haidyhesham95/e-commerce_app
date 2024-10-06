import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/api_service.dart';
import '../../core/shared_prefrense_token.dart';
import '../../domain/constracts/repository/wishlist_repo.dart';
import '../../domain/core/failure.dart';
import '../api/constance.dart';
import '../models/home_model/add_wishlist.dart';
import '../models/wishlist_model/wishlist_model.dart';


class WishlistRepoImpl extends WishlistRepo {
  final ApiService apiService;

  WishlistRepoImpl( this.apiService);




  @override
  Future<Either<Failure, WishlistModel>> getWishlist() async {
    try {
      final token = await SharedPreferenceToken.getToken();

      var response = await apiService.get(
        endPoint: EndPoints.wishlist,
        token: token,
      );

      if (response != null && response.isNotEmpty) {
        final wishlistModel = WishlistModel.fromJson(response);
        return Right(wishlistModel);
      } else {
        return Left(ServerFailure("Response is null or empty"));
      }
    } catch (e) {
      if (e is DioError) {
        return Left(ServerFailure.fromDiorError(e));
      }
      return Left(ServerFailure(e.toString()));
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
