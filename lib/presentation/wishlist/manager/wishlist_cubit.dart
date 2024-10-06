import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/wishlist_model/wishlist_model.dart';
import '../../../data/repository/wishlist_repo_impl.dart';
import '../../home/manager/home_cubit.dart';

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
  void removeProductFromWishlist({
    required String productId,
    required HomeCubit homeCubit
  }) async {
    emit(WishlistLoading());
    final result = await wishlistRepoImpl.removeProductFromWishList(productId);
    result.fold(
          (failure) => emit(WishlistFailure(message: failure.message)),
          (wishlistResponse) {
        getWishlist();
       homeCubit.toggleWishlist(productId);

        emit(WishlistProductRemoved());
      },
    );
  }




}

