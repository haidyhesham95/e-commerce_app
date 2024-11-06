import '../../../data/models/cart_model/cart_model.dart';
import '../../../presentation/cart/widget/cart_product_item.dart';
import '../../../presentation/cart/widget/checkout_card.dart';
import '../../../presentation/cart/widget/top_page_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../presentation/cart/manager/cart_cubit.dart';


class CartContent extends StatelessWidget {
  final CartModel cart;

  const CartContent({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
     final cubit = context.read<CartCubit>();
    //
    // if (cart.data?.products?.isEmpty ?? true) {
    //   return const Center(child: Text('Your cart is empty.'));
    // }

    return Column(
      children: [
        const SizedBox(height: 50),
        topPageCart(context,
            size: MediaQuery.of(context).size, cart: cart),
        const SizedBox(height: 15),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            physics: const BouncingScrollPhysics(),
            itemCount: cart.data?.products?.length ?? 0,
            itemBuilder: (context, index) {
              final product = cart.data?.products?[index];
              if (product == null) {
                return const SizedBox();
              }
              return CartProductItem(product: product, cubit: cubit);
            },
          ),
        ),
        CheckoutCard(cart: cart),
      ],
    );
  }
}
