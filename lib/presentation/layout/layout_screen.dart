import 'package:ecommerce_app/presentation/home/view/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/utils/style/color.dart';
import '../../generated/assets.dart';
import '../cart/view/cart_page.dart';
import '../wishlist/view/wishlist_page.dart';


class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  _LayoutScreenState createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomeView(),
    const WishlistPage(),
    const CartPage(),
    const WishlistPage(),
    const CartPage(),

  ];

  void setBottomBarIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: SizedBox(
       height: 80,
        child: Stack(
          children: [
          Container(
            height: 80,
            color: AppColors.gray,
            child: Image.asset(Assets.imagesVector,width: double.infinity,fit: BoxFit.fitWidth,),

          ),
              Center(
                heightFactor: 0.3,
                child: SizedBox(
                  width: 65,
                  height: 65,
                  child: FloatingActionButton(

                    shape: const StadiumBorder(),
                    backgroundColor: AppColors.blue,
                    onPressed: () {
                      setBottomBarIndex(2);
                    },
                    elevation: 2,
                    child: const Icon(CupertinoIcons.bag, color: Colors.white),
                  ),
                ),
              ),



            SizedBox(
              width: size.width,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildNavIcon(Icons.home, 0),
                  buildNavIcon(CupertinoIcons.heart, 1),
                  SizedBox(width: size.width * 0.20),
                  buildNavIcon(Icons.search, 3),
                  buildNavIcon(Icons.person_outline_rounded, 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNavIcon(IconData icon, int index) {
    return IconButton(
      icon: Icon(
        icon,
        size: 30,
        color: currentIndex == index ? AppColors.blue : Colors.grey,
      ),
      onPressed: () {
        setBottomBarIndex(index);
      },
    );
  }
}


