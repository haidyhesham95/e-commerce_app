import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/presentation/home/widget/specific_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/style/color.dart';
import '../../../core/utils/style/font_size.dart';
import '../../../generated/assets.dart';
import '../manager/home_cubit.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key, required this.size, required this.cubit, required this.productId, required this.index});

  final Size size;
  final HomeCubit cubit;
  final String productId;
  final int index;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SpecificProduct(
                  cubit: cubit,
                  products: cubit.products[index],
                  size: size,
                  productId: productId,
                  isInWishlist: false,
                ),
              ),
            );
          },
          child: Container(
            width: size.width * 0.52,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                  child: CachedNetworkImage(
                    imageUrl: cubit.products[index].imageCover ?? 'https://example.com/default-image.jpg',
                    height: size.height * 0.18,
                    width: size.width * 0.5,
                   // fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return Image.asset(Assets.imagesDownload, fit: BoxFit.cover);
                    },
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),


                ),
                const SizedBox(height: 10),
                Text(
                  '  ${cubit.products[index].title}' ,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.styleMedium18(context),
                ),

                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "  ${cubit.products[index].brand!.slug}" ,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.styleMedium16(context). copyWith(color: Colors.grey.shade600),

                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          cubit.products[index].ratingsAverage
                              ?.toString() ??
                              '5.0',
                          style: AppStyles.styleMedium15(context). copyWith(color: Colors.grey.shade600),
                        ),
                        const Icon(Icons.star, color: Colors.yellow, size: 20),
                      ],
                    ),
                  ],
                ),

                const Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text(
                        cubit.products[index].price != null
                            ? '  EGP ${cubit.products[index].price}'
                            : 'No price',
                        style: AppStyles.styleMedium16(context),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${cubit.products [index].priceAfterDiscount ?? 50} EGP',
                        style: AppStyles.styleMedium13(context).copyWith(
                          color: AppColors.blue,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 30,
                        width: 30,

                        decoration: const BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                        ),

                        child: Center(
                          child: IconButton(
                              onPressed: () {
                                cubit.addProductToCart(productId);
                              },
                              icon: const Icon(CupertinoIcons.add, color: Colors.white, size: 18)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -5,
          left: 0,
          child: IconButton(
            onPressed: () {
              cubit.toggleWishlist(productId);

            },
            icon: Icon(
              cubit.isProductInWishlist(productId) ? Icons.favorite : Icons.favorite_border,
              //color: isInWishlist ? Colors.red : Colors.grey,
              color: cubit.isProductInWishlist(productId) ? Colors.red : AppColors.blue,

            ),
          ),
        )


      ],
    );
  }
}
