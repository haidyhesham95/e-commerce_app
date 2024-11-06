import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/models/cart_model/cart_model.dart';
import '../../../data/repository/cart_repo_impl.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.cartRepoImpl) : super(CartInitial());

  static CartCubit get(context) => BlocProvider.of(context);
  final CartRepoImpl cartRepoImpl;

//   List<CartModel> cartModel = [];
  void getProductCart() async {
    emit(CartLoading());
    final result = await cartRepoImpl.getProductCart();
    result.fold(
      (failure) => emit(CartFailure(message: failure.message)),
      (cartModel) => emit(CartSuccess(cartModel: cartModel)),
    );
  }

  void incrementProductToCart(String productId, int count) async {
    emit(CartLoading());
    final result = await cartRepoImpl.incrementProductToCart(productId, count);
    result.fold(
      (failure) => emit(IncrementCartFailure(message: failure.message)),
      (_) => getProductCart(),
    );
  }

  void decrementProductToCart(String productId, int count) async {
    emit(CartLoading());
    final result = await cartRepoImpl.decrementProductToCart(productId, count);
    result.fold(
      (failure) => emit(DecrementCartFailure(message: failure.message)),
      (_) => getProductCart(),
    );
  }

  void deleteProductFromCart(String productId) async {
    emit(CartLoading());
    final result = await cartRepoImpl.deleteProductFromCart(productId);
    result.fold(
      (failure) => emit(DeleteCartFailure(message: failure.message)),
      (_) => getProductCart(),
    );
  }
}
