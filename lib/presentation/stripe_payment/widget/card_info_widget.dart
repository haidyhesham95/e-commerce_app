import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../generated/assets.dart';


class CardInfoWidget extends StatelessWidget {
  const CardInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 305,
      height: 73,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.imagesMasterCard),
          SizedBox(width: 23,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Credit Card",),
              Text("Mastercard **78",  ),

            ],
          )

        ],
      ),
    );
  }
}
