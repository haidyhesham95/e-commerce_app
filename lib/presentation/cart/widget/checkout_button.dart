import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/presentation/stripe_payment/view/thank_you_view.dart';
import '../../../core/api_service.dart';
import '../../../core/git_it.dart';
import '../../../core/utils/style/color.dart';
import '../../../core/utils/style/font_size.dart';
import '../../../data/repository/cart_repo_impl.dart';
import '../../stripe_payment/view_model/stripe_cubit.dart';

class CheckoutButton extends StatelessWidget {
  final int totalCartPrice;

  const CheckoutButton({super.key, required this.totalCartPrice});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StripeCubit(CartRepoImpl(getIt.get<ApiService>())),
      child: BlocConsumer<StripeCubit, StripeState>(
        listener: (context, state) {
          if (state is PaymentSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ThankYouView(total: totalCartPrice,)),
            );
            BlocProvider.of<StripeCubit>(context).clearCart();

          } 
          // else if (state is PaymentFailure) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(content: Text(state.error)),
          //   );
          // }
        },
        builder: (context, state) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blue,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed:(){
              BlocProvider.of<StripeCubit>(context).makePayment(
                totalCartPrice,
                'EGP',
              );
            },
            child: Text(
              state is PaymentLoading ? 'Processing...' : 'Checkout',
              style: AppStyles.styleMedium18(context).copyWith(
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
