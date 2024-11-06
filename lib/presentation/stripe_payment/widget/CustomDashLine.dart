import 'package:flutter/material.dart';

class CustomDashLine extends StatelessWidget {
  const CustomDashLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(20, (index) => Expanded(child:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        child: Container(color: Color(0XFFB8B8B8),height: 3,),
      ))),
    );
  }
}

