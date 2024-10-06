part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}
final class HomeDialogLoading extends HomeState {}


final class HomeSuccess extends HomeState {}

  final class HomeFailure extends HomeState {
  final String message;
  HomeFailure(this.message);
  }


  final class SearchSuccess extends HomeState {}

  final class SearchFailure extends HomeState {
  final String message;
  SearchFailure(this.message);
  }

  final class ExpiredTokenFailure extends HomeState {

  }
  final class AddProductToCartSuccess extends HomeState {
  final AddProductToCart addProductToCart;
  AddProductToCartSuccess(this.addProductToCart);

  }

final class LogoutSuccess  extends HomeState {}
final class LogoutError extends HomeState {
  final String message;
  LogoutError(this.message);
}
final class LogoutLoading extends HomeState {}



class AddProductToWishListSuccess extends HomeState{
  final List<WishlistResponse> wishlistResponseList;

  AddProductToWishListSuccess(this.wishlistResponseList);
}

final class AddProductToWishListLoading extends HomeState {}

final class AddProductToWishListError extends HomeState {
  final String message;
  AddProductToWishListError(this.message);
}

final class RemoveProductFromWishListSuccess extends HomeState {
  final List<WishlistResponse> wishlistResponseList;

  RemoveProductFromWishListSuccess(this.wishlistResponseList);
}

final class RemoveProductFromWishListLoading extends HomeState {}

final class RemoveProductFromWishListError extends HomeState {
  final String message;
  RemoveProductFromWishListError(this.message);
}

final class WishlistProductAlreadyAdded extends HomeState {}

class WishlistLoaded extends HomeState {
  final Set<String> wishlist;
  WishlistLoaded(this.wishlist);
}




class WishlistState extends HomeState {
  final List<String> wishlistItems; // List of product IDs in the wishlist
  final String? selectedProductId; // The currently selected product ID

  WishlistState({
    this.wishlistItems = const [],
    this.selectedProductId,
  });

  WishlistState copyWith({
    List<String>? wishlistItems,
    String? selectedProductId,
  }) {
    return WishlistState(
      wishlistItems: wishlistItems ?? this.wishlistItems,
      selectedProductId: selectedProductId ?? this.selectedProductId,
    );
  }

}
class CategorySelectedState extends HomeState {}

