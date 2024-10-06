import 'package:ecommerce_app/core/utils/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/api_service.dart';
import '../../../core/git_it.dart';
import '../../../core/utils/widgets/dialog.dart';
import '../../../data/repository/cart_repo_impl.dart';
import '../manager/cart_cubit.dart';
import '../widget/cart_product_item.dart';
import '../widget/checkout_card.dart';
import '../widget/top_page_cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.gray,
      body: BlocProvider(
        create: (context) => CartCubit(CartRepoImpl(getIt.get<ApiService>()))..getProductCart(),
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is IncrementCartSuccess || state is DecrementCartSuccess || state is UpdateCartSuccess) {
              showToast('Cart updated successfully');

              context.read<CartCubit>().getProductCart();
            }

            if( state is DeleteCartSuccess){
              showToast('Product removed from cart');
              context.read<CartCubit>().getProductCart();
            }
          },
          builder: (context, state) {
            final cubit = context.read<CartCubit>();

            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.blue),
              );
            }

            if (state is CartFailure) {
              return Center(child: Text(state.message));
            }

            if (state is CartSuccess) {
              final cart = state.cartModel;

              if (cart.data?.products?.isEmpty ?? true) {
                return const Center(child: Text('Your cart is empty.'));
              }
          return Column(
                    children: [
                      const SizedBox(height: 50),
                      topPageCart(context, size: MediaQuery.of(context).size, cart: cart),
                      const SizedBox(height: 15),

                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox (height: 20),
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
        return const SizedBox();
      },
    ),
  ),
);
  }
}
