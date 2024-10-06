part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartSuccess extends CartState {
  final CartModel cartModel;
  CartSuccess({required this.cartModel});
}

final class CartFailure extends CartState {
  final String message;
  CartFailure({required this.message});
}

final class CartDialogLoading extends CartState {}

final class IncrementCartSuccess extends CartState {
  final CartModel cartModel;
  IncrementCartSuccess({required this.cartModel});
}

final class DecrementCartSuccess extends CartState {
  final CartModel cartModel;

  DecrementCartSuccess({required this.cartModel});
}

final class DecrementCartFailure extends CartState {
  final String message;
  DecrementCartFailure({required this.message});
}

final class IncrementCartFailure extends CartState {
  final String message;
  IncrementCartFailure({required this.message});
}

class UpdateCartSuccess extends CartState {
  final CartModel cartModel;
  UpdateCartSuccess({required this.cartModel});
}

class UpdateCartFailure extends CartState {
  final String message;
  UpdateCartFailure({required this.message});
}

class DeleteCartSuccess extends CartState {
  final CartModel cartModel;
  DeleteCartSuccess({required this.cartModel});
}

class DeleteCartFailure extends CartState {
  final String message;
  DeleteCartFailure({required this.message});
}
