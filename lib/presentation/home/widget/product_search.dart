import 'package:ecommerce_app/presentation/home/widget/product_list.dart';
import 'package:flutter/material.dart';
import '../manager/home_cubit.dart';
class ProductSearch extends StatelessWidget {
  const ProductSearch({super.key, required this.size, required this.cubit});

  final Size size;
  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 15,
              mainAxisSpacing: 30,
            ),
            physics: const BouncingScrollPhysics(),
            //physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: cubit.filteredProducts.length,
            itemBuilder: (context, index) {
              final productId = cubit.filteredProducts[index].id!;
              return ProductList(
                size: size,
                cubit: cubit,
                productId: productId,
                index: index,
              );
            },
          ),
        ),
        const SizedBox(height: 200)

      ]

    );
  }
}
