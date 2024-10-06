import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/style/font_size.dart';
import '../../cart/view/cart_page.dart';
import '../../wishlist/view/wishlist_page.dart';
import '../manager/home_cubit.dart';
import 'logout_dialog.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff1483C2),
      child: ListView(
        children: [
          const SizedBox(height: 30),
          _buildUserInfo(context),
          const SizedBox(height: 20),
          const Divider(color: Colors.white, thickness: 1, indent: 10, endIndent: 10),
          const SizedBox(height: 10),
          _buildDrawerItem(
            context,
            icon: CupertinoIcons.person,
            title: 'Profile',
            onTap: () {
            },
          ),
          _buildDrawerItem(
            context,
            icon: CupertinoIcons.bag,
            title: 'My Cart',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
          ),
          _buildDrawerItem(
            context,
            icon: CupertinoIcons.heart,
            title: 'Favorite',
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WishlistPage()),
              ).then((value) {
                context.read<HomeCubit>().loadWishlist();
              });
              context.read<HomeCubit>().getProducts();
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.settings,
            title: 'Settings',
            onTap: () {
            },
          ),
          const SizedBox(height: 10),
          const Divider(color: Colors.white, thickness: 1, indent: 10, endIndent: 10),
          const SizedBox(height: 10),
          _buildDrawerItem(
            context,
            icon: CupertinoIcons.square_arrow_right,
            title: 'Logout',
            onTap: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('   Haidy Hesham', style: AppStyles.styleRegular23(context).copyWith(color: Colors.white)),
        Text('   haidyhesham@gmail.com', style: AppStyles.styleRegular18(context).copyWith(color: Colors.black54)),
      ],
    );
  }

  Widget _buildDrawerItem(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: AppStyles.styleMedium18(context).copyWith(color: Colors.white)),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const LogoutDialog();
      },
    );
  }
}
