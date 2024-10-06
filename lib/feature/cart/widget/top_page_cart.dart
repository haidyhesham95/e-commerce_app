import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../utils/style/font_size.dart';
import '../../home/widget/arrow_back.dart';
import '../model/cart_model.dart';

Padding topPageCart(BuildContext context ,{required Size size , required CartModel cart}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const ArrowBack(),
        Text(
          'My Cart',
          textAlign: TextAlign.center,
          style: AppStyles.TextStyleregular20(context),
        ),
        Stack(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: const Offset(0, 1),
                    ),
                  ]),
              child: const Center(
                child: Icon(CupertinoIcons.bag, size: 20),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: 15,
                width: 15,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${cart.numOfCartItems ?? 0}',
                    style: AppStyles.styleRegular9(context)
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}