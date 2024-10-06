
import 'package:flutter/material.dart';
import '../../../core/utils/style/font_size.dart';
import '../../../data/models/home_model/product_model.dart';
import 'arrow_back.dart';
import 'cart_count_icon.dart';

Padding buildAppBar(BuildContext context ,{required Size size, required ProductModel products}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const ArrowBack(),
        SizedBox(
          width: size.width * 0.6,
          child: Text(
            products.title ?? 'No title',
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.TextStyleregular20(context),
          ),
        ),
        const CartCountIcon(),
      ],
    ),
  );
}