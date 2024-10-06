import 'package:flutter/material.dart';

import '../../../core/utils/style/color.dart';
import '../../../core/utils/style/font_size.dart';
import '../../../data/models/home_model/product_model.dart';


Padding topDetailsPage(BuildContext context, {required Size size, required ProductModel products}) {
  return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            products.description ?? 'No description',
            maxLines: 1,
            style: AppStyles.style20medium(context),
          ),
          Text(
            '${products.category?.name ?? ''} (${products.brand
                ?.name ?? ''})',
            style: AppStyles.styleRegular15(context)
                .copyWith(color: Colors.grey.shade600),
          ),
          Row(
            children: [
              Text('EGP ${products.price}     ',
                  style: AppStyles.styleMedium18(context)),
              Text(
                '${products.priceAfterDiscount ?? 50} EGP',
                style: AppStyles.styleMedium13(context).copyWith(
                  color: AppColors.blue,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ],
      ),
    );
}
