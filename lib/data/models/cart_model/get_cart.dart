// import 'package:ecommerce_app/feature/home/model/product_model.dart';
//
// /// status : "success"
// /// numOfCartItems : 4
// /// cartId : "66d396f9aab694edafdccc63"
// /// data : {"_id":"66d396f9aab694edafdccc63","cartOwner":"66b8e78aed0dc0016c345b12","products":[{"count":2,"_id":"66dc6fae5af34029e7b81b93","product":{"subcategory":[{"_id":"6407f1bcb575d3b90bf95797","name":"Women's Clothing","slug":"women's-clothing","category":"6439d58a0049ad0b52b9003f"}],"_id":"6428e997dc1175abc65ca0a1","title":"Woman Shawl","quantity":220,"imageCover":"https://ecommerce.routemisr.com/Route-Academy-products/1680402838276-cover.jpeg","category":{"_id":"6439d58a0049ad0b52b9003f","name":"Women's Fashion","slug":"women's-fashion","image":"https://ecommerce.routemisr.com/Route-Academy-categories/1681511818071.jpeg"},"brand":{"_id":"64089bbe24b25627a253158b","name":"DeFacto","slug":"defacto","image":"https://ecommerce.routemisr.com/Route-Academy-brands/1678285758109.png"},"ratingsAverage":4.8,"id":"6428e997dc1175abc65ca0a1"},"price":149},{"count":2,"_id":"66dd7ec256ae2d2e54cc5427","product":{"subcategory":[{"_id":"6407f1bcb575d3b90bf95797","name":"Women's Clothing","slug":"women's-clothing","category":"6439d58a0049ad0b52b9003f"}],"_id":"6428e884dc1175abc65ca096","title":"Woman Shawl","quantity":228,"imageCover":"https://ecommerce.routemisr.com/Route-Academy-products/1680402563605-cover.jpeg","category":{"_id":"6439d58a0049ad0b52b9003f","name":"Women's Fashion","slug":"women's-fashion","image":"https://ecommerce.routemisr.com/Route-Academy-categories/1681511818071.jpeg"},"brand":{"_id":"64089bbe24b25627a253158b","name":"DeFacto","slug":"defacto","image":"https://ecommerce.routemisr.com/Route-Academy-brands/1678285758109.png"},"ratingsAverage":4.2,"id":"6428e884dc1175abc65ca096"},"price":349},{"count":3,"_id":"66dd7f7656ae2d2e54cc5952","product":{"subcategory":[{"_id":"6407f1bcb575d3b90bf95797","name":"Women's Clothing","slug":"women's-clothing","category":"6439d58a0049ad0b52b9003f"}],"_id":"6428ead5dc1175abc65ca0ad","title":"Woman Shawl","quantity":220,"imageCover":"https://ecommerce.routemisr.com/Route-Academy-products/1680403156501-cover.jpeg","category":{"_id":"6439d58a0049ad0b52b9003f","name":"Women's Fashion","slug":"women's-fashion","image":"https://ecommerce.routemisr.com/Route-Academy-categories/1681511818071.jpeg"},"brand":{"_id":"64089bbe24b25627a253158b","name":"DeFacto","slug":"defacto","image":"https://ecommerce.routemisr.com/Route-Academy-brands/1678285758109.png"},"ratingsAverage":4.8,"id":"6428ead5dc1175abc65ca0ad"},"price":149},{"count":5,"_id":"66e05f7317a12449e8c830a4","product":{"subcategory":[{"_id":"6407f1bcb575d3b90bf95797","name":"Women's Clothing","slug":"women's-clothing","category":"6439d58a0049ad0b52b9003f"}],"_id":"6428ebc6dc1175abc65ca0b9","title":"Woman Shawl","quantity":225,"imageCover":"https://ecommerce.routemisr.com/Route-Academy-products/1680403397402-cover.jpeg","category":{"_id":"6439d58a0049ad0b52b9003f","name":"Women's Fashion","slug":"women's-fashion","image":"https://ecommerce.routemisr.com/Route-Academy-categories/1681511818071.jpeg"},"brand":{"_id":"64089bbe24b25627a253158b","name":"DeFacto","slug":"defacto","image":"https://ecommerce.routemisr.com/Route-Academy-brands/1678285758109.png"},"ratingsAverage":4.8,"id":"6428ebc6dc1175abc65ca0b9"},"price":170}],"createdAt":"2024-08-31T22:19:37.329Z","updatedAt":"2024-09-11T13:00:48.878Z","__v":67,"totalCartPrice":2293}
//
// class GetUserCart {
//   GetUserCart({
//     this.status,
//     this.numOfCartItems,
//     this.cartId,
//     this.data,
//   });
//
//   GetUserCart.fromJson(dynamic json) {
//     status = json['status'];
//     numOfCartItems = json['numOfCartItems'];
//     cartId = json['cartId'];
//     data = json['data'] != null ? CartData.fromJson(json['data']) : null;
//   }
//
//   String? status;
//   int? numOfCartItems;
//   String? cartId;
//   CartData? data;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['numOfCartItems'] = numOfCartItems;
//     map['cartId'] = cartId;
//     if (data != null) {
//       map['data'] = data?.toJson();
//     }
//     return map;
//   }
// }
//
// /// _id : "66d396f9aab694edafdccc63"
// /// cartOwner : "66b8e78aed0dc0016c345b12"
// /// products : [{"count":2,"_id":"66dc6fae5af34029e7b81b93","product":{"subcategory":[{"_id":"6407f1bcb575d3b90bf95797","name":"Women's Clothing","slug":"women's-clothing","category":"6439d58a0049ad0b52b9003f"}],"_id":"6428e997dc1175abc65ca0a1","title":"Woman Shawl","quantity":220,"imageCover":"https://ecommerce.routemisr.com/Route-Academy-products/1680402838276-cover.jpeg","category":{"_id":"6439d58a0049ad0b52b9003f","name":"Women's Fashion","slug":"women's-fashion","image":"https://ecommerce.routemisr.com/Route-Academy-categories/1681511818071.jpeg"},"brand":{"_id":"64089bbe24b25627a253158b","name":"DeFacto","slug":"defacto","image":"https://ecommerce.routemisr.com/Route-Academy-brands/1678285758109.png"},"ratingsAverage":4.8,"id":"6428e997dc1175abc65ca0a1"},"price":149},{"count":2,"_id":"66dd7ec256ae2d2e54cc5427","product":{"subcategory":[{"_id":"6407f1bcb575d3b90bf95797","name":"Women's Clothing","slug":"women's-clothing","category":"6439d58a0049ad0b52b9003f"}],"_id":"6428e884dc1175abc65ca096","title":"Woman Shawl","quantity":228,"imageCover":"https://ecommerce.routemisr.com/Route-Academy-products/1680402563605-cover.jpeg","category":{"_id":"6439d58a0049ad0b52b9003f","name":"Women's Fashion","slug":"women's-fashion","image":"https://ecommerce.routemisr.com/Route-Academy-categories/1681511818071.jpeg"},"brand":{"_id":"64089bbe24b25627a253158b","name":"DeFacto","slug":"defacto","image":"https://ecommerce.routemisr.com/Route-Academy-brands/1678285758109.png"},"ratingsAverage":4.2,"id":"6428e884dc1175abc65ca096"},"price":349},{"count":3,"_id":"66dd7f7656ae2d2e54cc5952","product":{"subcategory":[{"_id":"6407f1bcb575d3b90bf95797","name":"Women's Clothing","slug":"women's-clothing","category":"6439d58a0049ad0b52b9003f"}],"_id":"6428ead5dc1175abc65ca0ad","title":"Woman Shawl","quantity":220,"imageCover":"https://ecommerce.routemisr.com/Route-Academy-products/1680403156501-cover.jpeg","category":{"_id":"6439d58a0049ad0b52b9003f","name":"Women's Fashion","slug":"women's-fashion","image":"https://ecommerce.routemisr.com/Route-Academy-categories/1681511818071.jpeg"},"brand":{"_id":"64089bbe24b25627a253158b","name":"DeFacto","slug":"defacto","image":"https://ecommerce.routemisr.com/Route-Academy-brands/1678285758109.png"},"ratingsAverage":4.8,"id":"6428ead5dc1175abc65ca0ad"},"price":149},{"count":5,"_id":"66e05f7317a12449e8c830a4","product":{"subcategory":[{"_id":"6407f1bcb575d3b90bf95797","name":"Women's Clothing","slug":"women's-clothing","category":"6439d58a0049ad0b52b9003f"}],"_id":"6428ebc6dc1175abc65ca0b9","title":"Woman Shawl","quantity":225,"imageCover":"https://ecommerce.routemisr.com/Route-Academy-products/1680403397402-cover.jpeg","category":{"_id":"6439d58a0049ad0b52b9003f","name":"Women's Fashion","slug":"women's-fashion","image":"https://ecommerce.routemisr.com/Route-Academy-categories/1681511818071.jpeg"},"brand":{"_id":"64089bbe24b25627a253158b","name":"DeFacto","slug":"defacto","image":"https://ecommerce.routemisr.com/Route-Academy-brands/1678285758109.png"},"ratingsAverage":4.8,"id":"6428ebc6dc1175abc65ca0b9"},"price":170}]
// /// createdAt : "2024-08-31T22:19:37.329Z"
// /// updatedAt : "2024-09-11T13:00:48.878Z"
// /// __v : 67
// /// totalCartPrice : 2293
// class CartData {
//   CartData({
//     this.id,
//     this.cartOwner,
//     this.products,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//     this.totalCartPrice,
//   });
//
//   CartData.fromJson(dynamic json) {
//     id = json['_id'];
//     cartOwner = json['cartOwner'];
//     if (json['products'] != null) {
//       products = [];
//       json['products'].forEach((v) {
//         products?.add(CartProduct.fromJson(v));
//       });
//     }
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     v = json['__v'];
//     totalCartPrice = json['totalCartPrice'];
//   }
//
//   String? id;
//   String? cartOwner;
//   List<CartProduct>? products;
//   String? createdAt;
//   String? updatedAt;
//   int? v;
//   int? totalCartPrice;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['_id'] = id;
//     map['cartOwner'] = cartOwner;
//     if (products != null) {
//       map['products'] = products?.map((v) => v.toJson()).toList();
//     }
//     map['createdAt'] = createdAt;
//     map['updatedAt'] = updatedAt;
//     map['__v'] = v;
//     map['totalCartPrice'] = totalCartPrice;
//     return map;
//   }
// }
//
// class CartProduct {
//   CartProduct({
//     this.count,
//     this.id,
//     this.product,
//     this.price,
//   });
//
//   CartProduct.fromJson(dynamic json) {
//     count = json['count'];
//     id = json['_id'];
//     product = json['product'] != null ? ProductModel.fromJson(json['product']) : null;
//     price = json['price'];
//   }
//
//   int? count;
//   String? id;
//   ProductModel? product;
//   int? price;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['count'] = count;
//     map['_id'] = id;
//     if (product != null) {
//       map['product'] = product?.toJson();
//     }
//     map['price'] = price;
//     return map;
//   }
// }


