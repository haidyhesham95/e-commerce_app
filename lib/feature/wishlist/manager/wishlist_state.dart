part of 'wishlist_cubit.dart';

@immutable
sealed class WishlistState {}

final class WishlistInitial extends WishlistState {}

final class WishlistLoading extends WishlistState {}

final class WishlistSuccess extends WishlistState {
  final WishlistModel wishlistModel;

  WishlistSuccess({required this.wishlistModel});

}

final class WishlistFailure extends WishlistState {
  final String message;

  WishlistFailure({required this.message});

}

final class WishlistProductRemoved extends WishlistState {

  WishlistProductRemoved();
}
