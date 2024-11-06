import 'package:ecommerce_app/core/utils/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../core/api_service.dart';
import '../../../core/git_it.dart';
import '../../../core/utils/style/font_size.dart';
import '../../../core/utils/widgets/dialog.dart';
import '../../../data/repository/cart_repo_impl.dart';
import '../../../generated/assets.dart';
import '../manager/cart_cubit.dart';
import '../widget/cart_content.dart';


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
            if (state is IncrementCartSuccess ||
                state is DecrementCartSuccess ||
                state is UpdateCartSuccess) {
              showToast('Cart updated successfully');
            }
            if (state is DeleteCartSuccess) {
              showToast('Product removed from cart');
            }
          },
          builder: (context, state) {
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
                return  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(Assets.imagesNoData),
                     Text('Your cart is empty.', style:AppStyles.styleMedium18(context) ),
                  ],
                );
              }
              return CartContent(cart: cart);
            }
            return const Center(
              child: CircularProgressIndicator(color: AppColors.blue),
            );
          },
        ),
      ),
    );
  }
}
