import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/models/cart_model/cart_model.dart';
import '../../../data/repository/cart_repo_impl.dart';


part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.cartRepoImpl) : super(CartInitial());

  static CartCubit get(context) => BlocProvider.of(context);

  List<CartModel> cartModel = [];
  final CartRepoImpl cartRepoImpl;


  void getProductCart() async {
    emit(CartLoading());
    final result = await cartRepoImpl.getProductCart();
    result.fold(
          (failure) => emit(CartFailure(message: failure.message)),
          (cartModel) {
        emit(CartSuccess(cartModel: cartModel));
      },
    );
  }

  void incrementProductToCart(String productId, int count) async {
    emit(CartLoading());
    final result = await cartRepoImpl.incrementProductToCart(productId, count);
    result.fold(
          (failure) => emit(IncrementCartFailure(message: failure.message)),
          (cartModel) {
        final updatedProducts = List<CartProduct>.from(cartModel.data!.products!);
        final productIndex = updatedProducts.indexWhere((prod) => prod.id == productId);
        if (productIndex != -1) {
          updatedProducts[productIndex].count = count;
        }
        emit(IncrementCartSuccess(cartModel: cartModel.copyWith(data: cartModel.data!.copyWith(products: updatedProducts))));
      },
    );
  }

  void decrementProductToCart(String productId, int count) async {
    emit(CartLoading());
    final result = await cartRepoImpl.decrementProductToCart(productId, count);
    result.fold(
          (failure) => emit(DecrementCartFailure(message: failure.message)),
          (cartModel) {
        final updatedProducts = List<CartProduct>.from(cartModel.data!.products!);
        final productIndex = updatedProducts.indexWhere((prod) => prod.id == productId);
        if (productIndex != -1) {
          updatedProducts[productIndex].count = count;
        }
        emit(DecrementCartSuccess(cartModel: cartModel.copyWith(data:cartModel.data!.copyWith(products: updatedProducts))));
      },
    );
  }

  void updateProductCountInCart(String productId, int newCount) async {
    emit(CartLoading());

    final result = await cartRepoImpl.updateProductCount(productId, newCount);

    result.fold(
          (failure) => emit(UpdateCartFailure(message: failure.message)),
          (cartModel) {
        final updatedProducts = List<CartProduct>.from(cartModel.data!.products!);
        final productIndex = updatedProducts.indexWhere((prod) => prod.id == productId);

        if (productIndex != -1) {
          updatedProducts[productIndex].count = newCount;
        }

        emit(UpdateCartSuccess(cartModel: cartModel.copyWith(
            data: cartModel.data!.copyWith(products: updatedProducts)
        )));
      },
    );
  }

  void deleteProductFromCart(String productId) async {
    emit(CartLoading());
    final result = await cartRepoImpl.deleteProductFromCart(productId);
    result.fold(
          (failure) => emit(DeleteCartFailure(message: failure.message)),
          (cartModel) {
            getProductCart();

        emit(DeleteCartSuccess(cartModel: cartModel));
      },
    );
  }


}



