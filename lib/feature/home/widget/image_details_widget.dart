import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../generated/assets.dart';
import '../../../utils/style/color.dart';
import '../model/product_model.dart';

class ImageDetailsWidget extends StatefulWidget {
  const ImageDetailsWidget({super.key, required this.products,});

  final ProductModel products;
  @override
  State<ImageDetailsWidget> createState() => _ImageDetailsWidgetState();
}

class _ImageDetailsWidgetState extends State<ImageDetailsWidget> {
  String? selectedImageUrl;
  bool isSelect = false;
  @override
  Widget build(BuildContext context) {
    const String baseUrl =
        "https://ecommerce.routemisr.com/Route-Academy-products/";
    String getFullImageUrl(String imageUrl) {
      if (imageUrl.startsWith('http') || imageUrl.startsWith('https')) {
        return imageUrl;
      } else {
        return baseUrl + imageUrl;
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child:
          CachedNetworkImage(
              imageUrl: selectedImageUrl ??widget.products.imageCover ?? 'https://th.bing.com/th/id/OIP.JfmZujC-oxQfceBsssqgjwHaEl?rs=1&pid=ImgDetMain',
              height: 250,
              width: double.infinity,
              fit: BoxFit.fill,
              placeholder: (context, url) => Image.asset(
                Assets.imagesDownload,
                height: 250,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              errorWidget: (context, url, error) => const Center(
                child: Icon(Icons.error, color: Colors.red),
              )),


        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:widget.products.images!.map<Widget>((imageUrl) {
              final fullImageUrl =
              getFullImageUrl(imageUrl); // Get the full URL
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedImageUrl = fullImageUrl;
                    isSelect = true;
                  });
                },
                child: Container(
                  height: 80,
                  width: 80,
                  margin: const EdgeInsets.only(right: 10, left: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selectedImageUrl == fullImageUrl
                          ? AppColors.blue
                          : Colors.white,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        offset: const Offset(0, 0),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child:
                    CachedNetworkImage(
                      imageUrl: fullImageUrl,
                      height: 80,
                      width: 80,
                      fit: BoxFit.fitWidth,
                      placeholder: (context, url) => Image.asset(
                        Assets.imagesDownload,
                        height: 80,
                        width: 80,
                        fit: BoxFit.fitWidth,
                      ),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),



                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
