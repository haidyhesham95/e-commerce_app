import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/feature/cart/model/cart_model.dart';
import 'package:ecommerce_app/feature/domain/repos/home_repo/home_repo.dart';
import 'package:ecommerce_app/feature/home/model/brand_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/home_repo/home_repo_impl.dart';
import '../model/add_cart.dart';
import '../model/add_wishlist.dart';
import '../model/categories_model.dart';
import '../model/product_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial()) {
    loadWishlist();
  }

  Set<String> wishlist = {};

  static HomeCubit get(context) => BlocProvider.of(context);
  TextEditingController searchController = TextEditingController();


  List<CategoriesModel> categories = [];
  List<ProductModel> products = [];
  List<Brand> brand = [];
  List<ProductModel> filteredProducts = [];

  final HomeRepo homeRepo;
  bool isSearching = false;

  void getCategories(String id) async {
    emit(HomeLoading());
    final result = await homeRepo.getCategories(id);
    result.fold(
      (failure) => emit(HomeFailure(failure.message)),
      (categories) {
        this.categories = categories;
        if (products != null) {
          emit(HomeSuccess());
        }
      },
    );
  }

  void getProducts() async {
    emit(HomeLoading());
    final result = await homeRepo.getProducts();
    result.fold(
      (failure) => emit(HomeFailure(failure.message)),
      (products) {
        this.products = products;
        filteredProducts = products;

        if (categories != null) {
          emit(HomeSuccess());
        }
      },
    );
  }
  void searchProducts(String query) {
    emit(HomeLoading());

    if (query.isEmpty) {
      filteredProducts = products;
      isSearching = false;
    } else {
      filteredProducts = products.where((product) => product.title!.toLowerCase().contains(query.toLowerCase())).toList();
      isSearching = true;
    }
    emit(HomeSuccess()); // Update UI based on search results
  }



  void getBrandProduct() async {
    emit(HomeLoading());
    final result = await homeRepo.brandProduct();
    result.fold(
      (failure) => emit(HomeFailure(failure.message)),
      (brand) {
        this.brand = brand;
        emit(HomeSuccess());
      },
    );
  }

  logOut() async {
    emit(LogoutLoading());
    var response = await homeRepo.logout();
    response.fold((failure) {
      emit(LogoutError(failure.message));
    }, (authModel) {
      emit(LogoutSuccess());
    });
  }

  void addProductToCart(String productId) async {
    emit(HomeDialogLoading());

    // Printing productId for debugging
    print('Adding product with ID: $productId');

    final result = await homeRepo.addProductToCart(productId);

    result.fold(
      (failure) {
        if (failure is ExpiredTokenFailure) {
          emit(ExpiredTokenFailure());
          print('Error: Token has expired');
        } else {
          emit(HomeFailure(failure.message));
          print('Error: ${failure.message}');
        }
      },
      (addProductToCart) {
        emit(AddProductToCartSuccess(addProductToCart));
        print('Product added successfully to cart');
      },
    );
  }


  Future<void> loadWishlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    wishlist = (prefs.getStringList('wishlist') ?? []).toSet();
    emit(WishlistLoaded(wishlist));
  }

  Future<void> saveWishlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('wishlist', wishlist.toList());
  }

  Future<void> toggleWishlist(String productId) async {
    if (wishlist.contains(productId)) {
      // Product already in wishlist, remove it
      emit(RemoveProductFromWishListLoading());
      final result = await homeRepo.removeProductFromWishList(productId);
      result.fold(
            (failure) => emit(RemoveProductFromWishListError(failure.message)),
            (wishlistResponse) {
          wishlist.remove(productId);
          saveWishlist();
          emit(RemoveProductFromWishListSuccess(wishlistResponse));
          emit(WishlistLoaded(wishlist)); // Emit updated wishlist state
        },
      );
    } else {
      // Product not in wishlist, add it
      emit(AddProductToWishListLoading());
      final result = await homeRepo.addProductToWishList(productId);
      result.fold(
            (failure) => emit(AddProductToWishListError(failure.message)),
            (wishlistResponse) {
          wishlist.add(productId);
          saveWishlist();
          emit(AddProductToWishListSuccess(wishlistResponse));
          emit(WishlistLoaded(wishlist)); // Emit updated wishlist state
        },
      );
    }
  }


  bool isProductInWishlist(String productId) {
    return wishlist.contains(productId);
  }


}
