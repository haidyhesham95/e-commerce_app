import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/feature/cart/manager/cart_cubit.dart';
import 'package:ecommerce_app/utils/style/color.dart';
import 'package:ecommerce_app/utils/style/font_size.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/feature/home/manager/home_cubit.dart'
as HomeCubit;
import '../../../generated/assets.dart';
import '../../home/widget/specific_product.dart';
import '../model/cart_model.dart';

import 'package:flutter_slidable/flutter_slidable.dart';



class CartProductItem extends StatelessWidget {
  const CartProductItem({
    super.key,
    required this.product,
    required this.cubit,
  });

  final CartProduct product;
  final CartCubit cubit;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Slidable(
      key: ValueKey(product.product?.id),
      startActionPane: ActionPane(
        extentRatio: 0.2,
        openThreshold: 0.2,
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () {
            cubit.deleteProductFromCart(product.product!.id!);
          },
        ),
        children: [
          SlidableAction(
            onPressed: (context) {
              cubit.deleteProductFromCart(product.product!.id!);
            },
            borderRadius: BorderRadius.circular(10),
            backgroundColor: Colors.red, // Set to transparent
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SpecificProduct(
                cubit: HomeCubit.HomeCubit.get(context),
                products:HomeCubit.HomeCubit.get(context).products.firstWhere((element) => element.id == product.product!.id) ,
                size: size,
                productId: product.product!.id!,
                isInWishlist: true,
              ),
            ),
          );
        },
        child: SizedBox(
          height: 140,
          child: Card(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Card(
                        color: AppColors.gray,
                        child:
                            CachedNetworkImage(
                                imageUrl: product.product?.imageCover ?? 'https://via.placeholder.com/100', fit: BoxFit.cover,
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                                placeholder: (context, url) => Image.asset(Assets.imagesDownload)

                            ),

                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 210,
                          child: Text(
                            product.product?.title ?? 'No Title',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.styleMedium18(context),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'EGP ${product.price}',
                          style: AppStyles.styleMedium16(context),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 130,
                      child: Card(
                        color: AppColors.blue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                cubit.updateProductCountInCart(product.product!.id!, product.count! + 1);
                              },
                              icon: const Icon(Icons.add, color: Colors.white, size: 25),
                            ),
                            Text(
                              '${product.count}',
                              style: AppStyles.styleMedium15(context).copyWith(color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () {
                                if (product.count! > 1) {
                                  cubit.updateProductCountInCart(product.product!.id!, product.count! - 1);
                                }
                              },
                              icon: const Icon(Icons.remove, color: Colors.white, size: 25),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

