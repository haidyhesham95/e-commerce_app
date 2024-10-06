import 'package:flutter/material.dart';

import '../../../utils/style/color.dart';
import '../../../utils/style/font_size.dart';
import '../model/cart_model.dart';

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
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blue,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
            },
            child:  Text('Checkout', style: AppStyles.styleMedium18(context).copyWith(
              color: Colors.white,
            )),
          ),
        ],
      ),
    );
  }
}
