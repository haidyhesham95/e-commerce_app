import 'package:ecommerce_app/presentation/stripe_payment/widget/thank_you_card.dart';
import 'package:flutter/material.dart';
import 'CustomCheckItem.dart';
import 'CustomDashLine.dart';

class ThankYouViewBody extends StatelessWidget {
  final int total;
  const ThankYouViewBody({super.key, required this.total});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Stack(
        clipBehavior: Clip.none,
        children:[
          ThankYouCard(total: total,),
          Positioned(
            bottom: MediaQuery.sizeOf(context).height*.2-5,
             left: 20+16,
            right:  20+8,
            child: CustomDashLine(),
          ),
          Positioned(
            left: -20,
              bottom: MediaQuery.sizeOf(context).height*.2,
              child: CircleAvatar(
            backgroundColor: Colors.white,
          )),
          Positioned(
              right: -20,
              bottom: MediaQuery.sizeOf(context).height*.2,
              child: CircleAvatar(
                backgroundColor: Colors.white,
              )),
          Positioned(
            left: 0,
            right: 0,
            top: -30,
            child: CustomCheckItem(),
          ),
        ]),
    );
  }
}
