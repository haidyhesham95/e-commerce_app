import 'package:flutter/material.dart';


class TotalPrice extends StatelessWidget {
  final String title,value; //key , value
  const TotalPrice({super.key,required this.value,required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, ),
        Spacer(),
        Text(value ,),

      ],
    );
  }
}
