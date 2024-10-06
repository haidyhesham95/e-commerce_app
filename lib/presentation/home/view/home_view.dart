import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/style/color.dart';
import '../../../core/utils/style/font_size.dart';
import '../../../core/utils/widgets/dialog.dart';
import '../../../generated/assets.dart';
import '../../auth/view/login.dart';
import '../manager/home_cubit.dart';
import '../widget/brand_item.dart';
import '../widget/drawer_widget.dart';
import '../widget/product_item.dart';
import '../widget/product_search.dart';
import '../widget/search_field.dart';
import '../widget/see_all_text.dart';
import '../widget/select_categories_item.dart';
import '../widget/slider_image.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool showAllBrands = false;
  bool showAllCategories = false;
  bool showAllProducts = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.gray,
      appBar: AppBar(
        backgroundColor: AppColors.gray,
        centerTitle: true,
        title:  const Image(image: AssetImage(Assets.imagesExplore), width: 120,),
      ),
      drawer:const CustomDrawer(),
      body: SingleChildScrollView(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomeDialogLoading) {
              showToast('Loading...');
            } else if (state is HomeFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is AddProductToCartSuccess) {
              showToast('Product added to cart');
            } else if (state is ExpiredTokenFailure) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
              );
            } else if (state is AddProductToWishListSuccess) {
             showToast('Product added to wishlist');
            } else if (state is RemoveProductFromWishListSuccess) {
              showToast('Product removed from wishlist');
            } else if (state is AddProductToWishListError) {
             showToast('Failed to add to wishlist');
            } else if (state is RemoveProductFromWishListError) {
              showToast('Failed to remove from wishlist');
            }
          },
          builder: (context, state) {
            final cubit = HomeCubit.get(context);

            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeSuccess || state is AddProductToCartSuccess || state is AddProductToWishListSuccess || state is RemoveProductFromWishListSuccess) {
              return _buildHomeContent(size, cubit);
            } else {
              return _buildHomeContent(size, cubit );
            }
          },
        ),
      ),
    );
  }

  Widget _buildHomeContent(Size size, HomeCubit cubit) {
    return Column(
      children: [
        SearchField(cubit: cubit),
        const SizedBox(height: 20),
        if (cubit.isSearching) ...[
          if (cubit.filteredProducts.isNotEmpty)
            SizedBox(
              height: size.height,
              child: ProductSearch(size: size, cubit: cubit),
            ),
          if (cubit.filteredProducts.isEmpty)
            Text(
              'No products found',
              style: AppStyles.styleMedium18(context),
            ),
        ] else ...[
          SliderImage(size: size),
          const SizedBox(height: 20),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '  Select Categories',
              style: AppStyles.styleMedium18(context),
            ),
          ),

          const SizedBox(height: 20),
          SelectCategoriesItem(size: size, cubit: cubit),

          const SizedBox(height: 20),
          SeeAllText(text: '  Products', showAll: showAllProducts, onToggle: () {
            setState(() {
              showAllProducts = !showAllProducts;
            });
          }),
          const SizedBox(height: 20),
          ProductItem(size: size, cubit: cubit ,showAll: showAllProducts,),
          const SizedBox(height: 20),
          SeeAllText(
            text: '  Brands',
            showAll: showAllBrands,
            onToggle: () {
              setState(() {
                showAllBrands = !showAllBrands;
              });
            },
          ),
          BrandItem(
            size: size,
            cubit: cubit,
            showAll: showAllBrands,
          ),
          const SizedBox(height: 20),
        ],
      ],
    );
  }
}
