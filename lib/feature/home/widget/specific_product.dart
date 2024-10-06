import 'package:ecommerce_app/feature/home/model/product_model.dart';
import 'package:ecommerce_app/feature/home/widget/image_details_widget.dart';
import 'package:ecommerce_app/feature/home/widget/top_details_page.dart';
import 'package:ecommerce_app/utils/style/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:readmore/readmore.dart';

import '../../../utils/style/font_size.dart';

import '../manager/home_cubit.dart';
import 'app_bar_page.dart';

class SpecificProduct extends StatefulWidget {
  SpecificProduct({
    super.key,
    required this.cubit,
    required this.products,
    required this.size,
    required this.productId,
    required this.isInWishlist,
  });

  final HomeCubit cubit;
  final Size size;
  final ProductModel products;
  final String productId;

  late bool isInWishlist;

  @override
  State<SpecificProduct> createState() => _SpecificProductState();
}

class _SpecificProductState extends State<SpecificProduct> {


  @override
  void initState() {
    super.initState();
    widget.isInWishlist = widget.cubit.isProductInWishlist(widget.productId);
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColors.gray,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            buildAppBar(context, size: widget.size, products: widget.products),
            const SizedBox(height: 30),
            topDetailsPage(context, size: widget.size, products: widget.products),
            const SizedBox(height: 20),
            ImageDetailsWidget(
              products: widget.products,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: ReadMoreText(
                      widget.products.description != null
                          ? "${widget.products.description!}."
                              .replaceAll('\t', ' ')
                              .replaceAll('\n', ' ')
                              .replaceAll(RegExp(r'\s+'), ' ')
                          : 'No description available',
                      trimLines: 3,
                      style: AppStyles.styleRegular20(context),
                      colorClickableText: AppColors.dark,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: '...Read more',
                      trimExpandedText: ' Read less',
                      moreStyle: AppStyles.styleMedium18(context)
                          .copyWith(color: AppColors.blue),
                      lessStyle: AppStyles.styleMedium18(context)
                          .copyWith(color: AppColors.blue),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star,
                              color: Colors.yellow.shade700, size: 22),
                          Text(" ${widget.products.ratingsAverage ?? ' 0.0'},",
                              style: AppStyles.styleRegular15(context)),
                        ],
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          Icon(Icons.shopping_bag_outlined,
                              color: Colors.grey.shade600, size: 19),
                          Text('${widget.products.quantity}',
                              style: AppStyles.styleRegular15(context)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    radius: 30,
                    child: IconButton(
                      icon: Icon(
                        widget.isInWishlist
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        color:
                            widget.isInWishlist ? Colors.red : AppColors.blue,
                        size: 30,
                      ),
                      onPressed: () async {
                        setState(() {
                          widget.isInWishlist = !widget.isInWishlist;
                        });
                        await widget.cubit.toggleWishlist(widget.productId);
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        widget.cubit.addProductToCart(widget.products.id!);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(CupertinoIcons.bag, color: Colors.white),
                          const SizedBox(width: 20),
                          Text(
                            'Add to Cart',
                            style: AppStyles.styleRegular25(context)
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
