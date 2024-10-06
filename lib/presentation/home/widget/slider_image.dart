import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import '../../../core/utils/style/color.dart';

class SliderImage extends StatelessWidget {
  const SliderImage({super.key, required this.size});
final Size size;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ImageSlideshow(
        width: double.infinity,
        height: size.height * 0.2,
        initialPage: 0,
        indicatorPadding: 15,
        indicatorColor: AppColors.blue,
        indicatorBackgroundColor: Colors.grey,
        isLoop: true,
        autoPlayInterval: 3000,
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://ecommerce.routemisr.com/Route-Academy-categories/1681511121316.png',
              fit: BoxFit.fill,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),

            child: Image.network(
              'https://ecommerce.routemisr.com/Route-Academy-categories/1681511452254.png',
              fit: BoxFit.fill,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://ecommerce.routemisr.com/Route-Academy-categories/1681511392672.png',
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
