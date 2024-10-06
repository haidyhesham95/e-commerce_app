// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../manager/home_cubit.dart';
//
// class WishlistButton extends StatelessWidget {
//   final String productId;
//
//   const WishlistButton({Key? key, required this.productId}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<HomeCubit>();
//
//     return BlocBuilder<HomeCubit, HomeState>(
//       builder: (context, state) {
//         bool isInWishlist = cubit.isProductInWishlist(productId);
//
//         return Positioned(
//           top: 10,
//           right: 10,
//           child: InkWell(
//             onTap: () {
//               if (isInWishlist) {
//                 cubit.removeProductFromWishList(productId);
//               } else {
//                 cubit.addProductToWishList(productId);
//               }
//             },
//             child: CircleAvatar(
//               backgroundColor: Colors.white,
//               child: Icon(
//                 Icons.favorite,
//                 color: isInWishlist ? Colors.red : Colors.grey,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
