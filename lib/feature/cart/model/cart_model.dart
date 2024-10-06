import '../../home/model/brand_model.dart';

import '../../home/model/brand_model.dart';

class CartModel {
  String? status;
  int? numOfCartItems;
  String? cartId;
  CartData? data;

  CartModel({
    this.status,
    this.numOfCartItems,
    this.cartId,
    this.data,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      status: json['status'],
      numOfCartItems: json['numOfCartItems'],
      cartId: json['cartId'],
      data: json['data'] != null ? CartData.fromJson(json['data']) : null,
    );
  }

  // Implementing copyWith method
  CartModel copyWith({
    String? status,
    int? numOfCartItems,
    String? cartId,
    CartData? data,
  }) {
    return CartModel(
      status: status ?? this.status,
      numOfCartItems: numOfCartItems ?? this.numOfCartItems,
      cartId: cartId ?? this.cartId,
      data: data ?? this.data,
    );
  }
}

class CartData {
  String? id;
  String? cartOwner;
  List<CartProduct>? products;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? totalCartPrice;

  CartData({
    this.id,
    this.cartOwner,
    this.products,
    this.createdAt,
    this.updatedAt,
    this.totalCartPrice,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      id: json['_id'],
      cartOwner: json['cartOwner'],
      products: (json['products'] as List?)
          ?.map((item) => CartProduct.fromJson(item))
          .toList(),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      totalCartPrice: json['totalCartPrice'],
    );
  }

  // Implementing copyWith method
  CartData copyWith({
    String? id,
    String? cartOwner,
    List<CartProduct>? products,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? totalCartPrice,
  }) {
    return CartData(
      id: id ?? this.id,
      cartOwner: cartOwner ?? this.cartOwner,
      products: products ?? this.products,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      totalCartPrice: totalCartPrice ?? this.totalCartPrice,
    );
  }
}

class CartProduct {
  int? count;
  String? id;
  ProductDetails? product;
  int? price;

  CartProduct({
    this.count,
    this.id,
    this.product,
    this.price,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      count: json['count'],
      id: json['_id'],
      product: json['product'] != null
          ? ProductDetails.fromJson(json['product'])
          : null,
      price: json['price'],
    );
  }

  // Implementing copyWith method
  CartProduct copyWith({
    int? count,
    String? id,
    ProductDetails? product,
    int? price,
  }) {
    return CartProduct(
      count: count ?? this.count,
      id: id ?? this.id,
      product: product ?? this.product,
      price: price ?? this.price,
    );
  }
}

class ProductDetails {
  String? id;
  String? title;
  int? quantity;
  String? imageCover;
  Category? category;
  Brand? brand;
  double? ratingsAverage;

  ProductDetails({
    this.id,
    this.title,
    this.quantity,
    this.imageCover,
    this.category,
    this.brand,
    this.ratingsAverage,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: json['_id'],
      title: json['title'],
      quantity: json['quantity'],
      imageCover: json['imageCover'],
      category: json['category'] != null
          ? Category.fromJson(json['category'])
          : null,
      brand: json['brand'] != null ? Brand.fromJson(json['brand']) : null,
      ratingsAverage: json['ratingsAverage']?.toDouble(),
    );
  }

  // Implementing copyWith method
  ProductDetails copyWith({
    String? id,
    String? title,
    int? quantity,
    String? imageCover,
    Category? category,
    Brand? brand,
    double? ratingsAverage,
  }) {
    return ProductDetails(
      id: id ?? this.id,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      imageCover: imageCover ?? this.imageCover,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      ratingsAverage: ratingsAverage ?? this.ratingsAverage,
    );
  }
}

class Category {
  String? id;
  String? name;
  String? slug;
  String? image;

  Category({
    this.id,
    this.name,
    this.slug,
    this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['image'] = image;
    return map;
  }

  // Implementing copyWith method
  Category copyWith({
    String? id,
    String? name,
    String? slug,
    String? image,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      image: image ?? this.image,
    );
  }
}
