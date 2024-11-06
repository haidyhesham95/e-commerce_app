import 'package:flutter/material.dart';
import '../../../core/utils/style/color.dart';
import '../../../core/utils/style/font_size.dart';
import '../../../data/models/cart_model/cart_model.dart';
import 'checkout_button.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({super.key,required this.cart});

  final  CartModel cart;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Price',
                style:AppStyles.styleMedium16(context),
              ),
              Text(
                'EGP ${cart.data?.totalCartPrice ?? 0}',
                style:AppStyles.styleMedium16(context).copyWith(
                  color: AppColors.blue,
                ),
              ),

            ],
          ),
          const SizedBox(height: 12),

          CheckoutButton(totalCartPrice: cart.data?.totalCartPrice ?? 0),
        ],
      ),
    );
  }
}



