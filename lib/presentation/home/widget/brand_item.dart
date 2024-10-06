import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/style/color.dart';
import '../../../generated/assets.dart';
import '../manager/home_cubit.dart';


class BrandItem extends StatelessWidget {
  const BrandItem({
    super.key,
    required this.size,
    required this.cubit,
    required this.showAll,
  });

  final Size size;
  final HomeCubit cubit;
  final bool showAll;

  @override
  Widget build(BuildContext context) {
    if (cubit.brand.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.blue,)
      );
    }
    return SizedBox(
      height: size.height * 0.28,
      width: double.infinity,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 15,
        ),
        itemCount: showAll ? cubit.brand.length : 6,
        itemBuilder: (context, index) => Center(
          child: CachedNetworkImage(
            imageUrl: cubit.brand[index].image ?? '',
            fit: BoxFit.fitWidth,
            placeholder: (context, url) {
              return Center(
                child: Image.asset(Assets.imagesDownload),
              );
            },
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
