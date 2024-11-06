
import 'package:flutter/material.dart';


class OrderInfoItem extends StatelessWidget {
  final String title,value; //key , value
  const OrderInfoItem({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, ),
        Spacer(),
        Text(value , ),

      ],
    );
  }
}

