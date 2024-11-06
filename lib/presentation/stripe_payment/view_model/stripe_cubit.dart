import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/data/models/cart_model/delete_cart_model.dart';
import 'package:meta/meta.dart';

import '../../../data/repository/cart_repo_impl.dart';
import '../view/payment_manager.dart';

part 'stripe_state.dart';




class StripeCubit extends Cubit<StripeState> {
  StripeCubit(this.cartRepoImpl) : super(StripeInitial());
  final CartRepoImpl cartRepoImpl;

  Future<void> makePayment(int amount, String currency) async {
    try {
      emit(PaymentLoading());
      await PaymentManager.makePayment(amount, currency);
      emit(PaymentSuccess());
    } catch (e) {
      emit(PaymentFailure(error: e.toString()));
    }
  }

  Future<void> clearCart() async {
    try {
      emit(PaymentDialogLoading());
      final result = await cartRepoImpl.clearCart();
      result.fold(
        (failure) => emit(PaymentDialogFailure(message: failure.message)),
        (deleteCartModel) => emit(PaymentDialogSuccess(deleteCartModel: deleteCartModel)),
      );
    } catch (e) {
      emit(PaymentDialogFailure(message: e.toString()));
    }
  }

}
