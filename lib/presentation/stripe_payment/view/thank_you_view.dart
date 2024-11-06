import 'package:ecommerce_app/presentation/stripe_payment/widget/thank_you_view_body.dart';
import 'package:flutter/material.dart';


class ThankYouView extends StatelessWidget {
  final int total;
  const ThankYouView({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Transform.translate(
          offset: Offset(0,-1),
          child: ThankYouViewBody(total: total,)) ,
    );
  }
}
