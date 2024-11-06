import 'package:flutter/material.dart';


class PaymentItemInfo extends StatelessWidget {
  const PaymentItemInfo({super.key,required this.title,required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
        ),
        Text(
          value,
        ),
      ],
    );
  }
}
