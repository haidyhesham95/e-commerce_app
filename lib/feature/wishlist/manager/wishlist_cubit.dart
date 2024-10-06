import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/feature/data/wishlist_repo/wishlist_repo_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../home/manager/home_cubit.dart';
import '../model/wishlist_model.dart';

part 'wishlist_state.dart';
class WishlistCubit extends Cubit<WishlistState> {
  final WishlistRepoImpl wishlistRepoImpl;

  WishlistCubit(this.wishlistRepoImpl) : super(WishlistInitial());

  static WishlistCubit get(context) => BlocProvider.of(context);

  WishlistModel? wishlistModel;

  void getWishlist() async {
    emit(WishlistLoading());
    final result = await wishlistRepoImpl.getWishlist();

    result.fold(
          (failure) {
        emit(WishlistFailure(message: failure.message));
      },
          (wishlist) {
        wishlistModel = wishlist;
        emit(WishlistSuccess(wishlistModel: wishlistModel!));
      },
    );
  }
  // void removeProductFromWishlist({ required String productId,  required HomeCubit homeCubit}) async {
  //   emit(WishlistLoading());
  //   final result = await wishlistRepoImpl.removeProductFromWishList(productId);
  //   result.fold(
  //         (failure) => emit(WishlistFailure(message: failure.message)),
  //         (wishlistResponse) {
  //       getWishlist();
  //
  //       emit(WishlistProductRemoved( homeCubit: homeCubit));
  //     },
  //   );
  // }
  void removeProductFromWishlist({
    required String productId,
    required HomeCubit homeCubit
  }) async {
    emit(WishlistLoading());
    final result = await wishlistRepoImpl.removeProductFromWishList(productId);
    result.fold(
          (failure) => emit(WishlistFailure(message: failure.message)),
          (wishlistResponse) {
        // Refresh the wishlist
        getWishlist();

        // Toggle the wishlist in the HomeCubit
        homeCubit.toggleWishlist(productId);

        // Emit the success state
        emit(WishlistProductRemoved());
      },
    );
  }




}

