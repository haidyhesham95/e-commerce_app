import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/feature/home/manager/home_cubit.dart'
    as HomeCubit;
import 'package:ecommerce_app/feature/home/widget/arrow_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/assets.dart';
import '../../../utils/api_service.dart';
import '../../../utils/git_it.dart';
import '../../../utils/style/color.dart';
import '../../../utils/style/font_size.dart';
import '../../data/wishlist_repo/wishlist_repo_impl.dart';
import '../../home/widget/specific_product.dart';
import '../manager/wishlist_cubit.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.gray,
      body: BlocProvider(
        create: (context) => WishlistCubit(
          WishlistRepoImpl(
            getIt.get<ApiService>(),
          ),
        )..getWishlist(),
        child: BlocConsumer<WishlistCubit, WishlistState>(
          listener: (context, state) {
            if (state is WishlistLoading) {
              const Center(
                child: CircularProgressIndicator(color: AppColors.blue),
              );
            } else if (state is WishlistFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            } else if (state is WishlistProductRemoved) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Product removed from wishlist!'),
                ),
              );
              context.read<WishlistCubit>().getWishlist();
            }
          },
          builder: (context, state) {
            if (state is WishlistLoading) {
              return const Center(
                child: CircularProgressIndicator( color: AppColors.blue),
              );
            } else if (state is WishlistSuccess) {
              final wishlist = state.wishlistModel;
              if (wishlist.data?.isEmpty ?? true) {
                return const Center(
                  child: Text('Your wishlist is empty.'),
                );
              }

              return Column(
                children: [
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const ArrowBack(),
                        Text(
                          'Favorite ',
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
                                child: Icon(CupertinoIcons.heart, size: 20),
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
                                    '${wishlist.data?.length}',
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
                  ),
                  const SizedBox(height: 25),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: wishlist.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final product = wishlist.data![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SpecificProduct(
                                  cubit: HomeCubit.HomeCubit.get(context),
                                  products: product,
                                  size: size,
                                  productId: product.id ?? '',
                                  isInWishlist: true,
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                      child:
                                          CachedNetworkImage(
                                            imageUrl: product.imageCover ?? 'https://via.placeholder.com/150',
                                            height: 180,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => Image.asset(
                                              Assets.imagesDownload,
                                            ),
                                            errorWidget: (context, url, error) => const Center(
                                              child: Icon(Icons.error, color: Colors.red),
                                            ),
                                          )


                                    ),
                                    const SizedBox(height: 15),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.title ?? 'Product Name',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppStyles.styleMedium15(context),
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Text(
                                                'EGP ${product.price ?? 0}    ',
                                                style: AppStyles.styleMedium13(context),
                                              ),
                                              Text(
                                                '${product.priceAfterDiscount ?? 50} EGP',
                                                style: AppStyles.styleMedium12(context).copyWith(
                                                  color: AppColors.blue,
                                                  decoration: TextDecoration.lineThrough,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 12,
                                left: 12,
                                child: InkWell(
                                  onTap: () {
                                    context.read<WishlistCubit>().removeProductFromWishlist(
                                      productId: product.id ?? '',
                                      homeCubit: HomeCubit.HomeCubit.get(context),
                                    );
                                  },

                                  child: const CircleAvatar(
                                    radius: 15,
                                    foregroundColor: AppColors.gray,
                                    backgroundColor: AppColors.gray,
                                    child: Icon(CupertinoIcons.heart_solid, color: Colors.red, size: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is WishlistFailure) {
              return Center(
                child: Text(state.message),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
