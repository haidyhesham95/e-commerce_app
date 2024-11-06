import 'package:ecommerce_app/presentation/home/widget/product_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/style/color.dart';
import '../manager/home_cubit.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
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
    if (cubit.products.isEmpty) {
      return const Center(
        child:   CircularProgressIndicator(color: AppColors.blue,)
      );
    }

    return SizedBox(
      height: size.height * 0.34,
      child: ListView.separated(
        separatorBuilder: (context, index) => const Row(
          children: [
            SizedBox(width: 15),
          ],
        ),
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: showAll ? cubit.products.length : (cubit.products.length > 6 ? 6 : cubit.products.length),
        itemBuilder: (context, index) {
          final productId = cubit.products[index].id!;

          return ProductList(
            size: size,
            cubit: cubit,
            productId: productId,
            index: index,
          );
        },
      ),
    );
  }
}
