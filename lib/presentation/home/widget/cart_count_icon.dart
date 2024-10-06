import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/api_service.dart';
import '../../../core/git_it.dart';
import '../../../core/utils/style/font_size.dart';
import '../../../data/repository/cart_repo_impl.dart';
import '../../cart/manager/cart_cubit.dart';
import '../../cart/view/cart_page.dart';

class CartCountIcon extends StatelessWidget {
  const CartCountIcon({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow:  [
                BoxShadow(
                  color: Colors.grey.shade400,
                  offset: const Offset(0, 1),
                ),
              ]
          ),
          child: Center(
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  const CartPage()));

              },
              icon: const Icon(CupertinoIcons.bag, size: 20),
            ),
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
              child: BlocBuilder<CartCubit, CartState>(
                bloc:CartCubit(
                  CartRepoImpl(
                    getIt.get<ApiService>(),
                  ),
                )..getProductCart(),
                builder: (BuildContext context, CartState state) {
                  return Text(
                    state is CartSuccess
                        ? state.cartModel.numOfCartItems.toString()
                        : '0',
                    style: AppStyles.styleRegular9(context)
                        .copyWith(color: Colors.white),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
