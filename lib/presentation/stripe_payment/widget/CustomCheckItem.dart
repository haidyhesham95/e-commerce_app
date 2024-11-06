
import 'package:flutter/material.dart';

class CustomCheckItem extends StatelessWidget {
  const CustomCheckItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundColor:   Color(0XFFD9D9D9),
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.green,
        child: Icon(Icons.check,color: Colors.white,size: 50,),
      ),
    );
  }
}

