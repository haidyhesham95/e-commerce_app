part of 'stripe_cubit.dart';

@immutable
sealed class StripeState {}

final class StripeInitial extends StripeState {}


class PaymentInitial extends StripeState {}

class PaymentLoading extends StripeState {}

class PaymentSuccess extends StripeState {}

class PaymentFailure extends StripeState {
  final String error;

  PaymentFailure({required this.error});
}

class PaymentDialogLoading extends StripeState {}
class PaymentDialogSuccess extends StripeState {
  final DeleteCartModel deleteCartModel;

  PaymentDialogSuccess({required this.deleteCartModel});
}
class PaymentDialogFailure extends StripeState {
  final String message;

  PaymentDialogFailure({required this.message});
}
