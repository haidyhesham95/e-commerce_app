import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/presentation/home/widget/specific_product.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/style/color.dart';
import '../../../core/utils/style/font_size.dart';
import '../../../generated/assets.dart';
import '../manager/home_cubit.dart';
import 'package:flutter/cupertino.dart';

class SelectCategoriesItem extends StatefulWidget {
  const SelectCategoriesItem({
    super.key,
    required this.size,
    required this.cubit,
  });

  final Size size;
  final HomeCubit cubit;

  @override
  _SelectCategoriesItemState createState() => _SelectCategoriesItemState();
}

class _SelectCategoriesItemState extends State<SelectCategoriesItem> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    String? selectedCategoryName = selectedIndex != null
        ? widget.cubit.categories[selectedIndex!].name
        : null;

    var filteredProducts = selectedCategoryName != null
        ? widget.cubit.products
            .where((product) =>
                product.category!.name?.toLowerCase() ==
                selectedCategoryName.toLowerCase())
            .toList()
        : [];

    print('Selected Category Name: $selectedCategoryName');
    print(
        'Filtered Products: ${filteredProducts.map((product) => product.category!.name).toList()}');

    return Column(
      children: [
        SizedBox(
          height: 40,
          width: double.infinity,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.cubit.categories.length,
            itemBuilder: (context, index) {
              bool isSelected = selectedIndex == index;
              return TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    isSelected ? AppColors.blue : Colors.white,
                  ),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
                onPressed: () {
                  setState(() {
                    selectedIndex = index;
                    print(
                        'Selected Category: ${widget.cubit.categories[selectedIndex!].name}');
                    filteredProducts = widget.cubit.products
                        .where((product) =>
                            product.category!.name?.toLowerCase() ==
                            widget.cubit.categories[selectedIndex!].name
                                ?.toLowerCase())
                        .toList();
                    print(
                        'Filtered Products: ${filteredProducts.map((product) => product.category!.name).toList()}');
                  });
                },
                child: Text(
                  widget.cubit.categories[index].name ?? 'no name',
                  style: AppStyles.styleMedium12(context).copyWith(
                    color: isSelected ? Colors.white : AppColors.blue,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        selectedIndex == null
            ? Center(child: SizedBox())
            : filteredProducts.isNotEmpty
                ? SizedBox(
                    height: widget.size.height * 0.3,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Row(
                        children: [
                          SizedBox(width: 15),
                        ],
                      ),
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final productId = filteredProducts[index].id!;

                        return Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SpecificProduct(
                                      cubit: widget.cubit,
                                      products: filteredProducts[index],
                                      size: widget.size,
                                      productId: productId,
                                      isInWishlist: false,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12)),
                                      child: CachedNetworkImage(
                                        imageUrl: filteredProducts[index]
                                                .imageCover ??
                                            'https://example.com/default-image.jpg',
                                        height: widget.size.height * 0.18,
                                        width: 200,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) {
                                          return Image.asset(
                                              Assets.imagesDownload,
                                              fit: BoxFit.cover);
                                        },
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      '  ${filteredProducts[index].title}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppStyles.styleMedium18(context),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 140,
                                          child: Text(
                                            "  ${filteredProducts[index].brand!.slug}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                AppStyles.styleMedium16(context)
                                                    .copyWith(
                                                        color: Colors
                                                            .grey.shade600),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              filteredProducts[index]
                                                      .ratingsAverage
                                                      ?.toString() ??
                                                  '5.0',
                                              style: AppStyles.styleMedium15(
                                                      context)
                                                  .copyWith(
                                                      color:
                                                          Colors.grey.shade600),
                                            ),
                                            const Icon(Icons.star,
                                                color: Colors.yellow, size: 20),
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
                                            filteredProducts[index].price !=
                                                    null
                                                ? '  EGP ${filteredProducts[index].price}'
                                                : 'No price',
                                            style: AppStyles.styleMedium16(
                                                context),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            '${filteredProducts[index].priceAfterDiscount ?? 50} EGP',
                                            style:
                                                AppStyles.styleMedium13(context)
                                                    .copyWith(
                                              color: AppColors.blue,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: const BoxDecoration(
                                              color: AppColors.blue,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  bottomRight:
                                                      Radius.circular(12)),
                                            ),
                                            child: Center(
                                              child: IconButton(
                                                  onPressed: () {
                                                    widget.cubit
                                                        .addProductToCart(
                                                            productId);
                                                  },
                                                  icon: const Icon(
                                                      CupertinoIcons.add,
                                                      color: Colors.white,
                                                      size: 18)),
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
                                  widget.cubit.toggleWishlist(productId);
                                },
                                icon: Icon(
                                  widget.cubit.isProductInWishlist(productId)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  //color: isInWishlist ? Colors.red : Colors.grey,
                                  color: widget.cubit
                                          .isProductInWishlist(productId)
                                      ? Colors.red
                                      : AppColors.blue,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ))
                : Center(
                    child: Text(
                      'No products available',
                      style: AppStyles.styleMedium18(context),
                    ),
                  ),
      ],
    );
  }
}
