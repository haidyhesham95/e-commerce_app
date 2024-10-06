import 'package:flutter/material.dart';
import '../../../core/utils/style/color.dart';
import '../../../core/utils/style/font_size.dart';

class CheckAccountText extends StatelessWidget {
  const CheckAccountText({super.key, required this.text1, required this.text2,required this.onPressed});
final String text1;
final String text2;
final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: AppStyles.styleMedium18(context).copyWith(color: Colors.grey)),

        InkWell(
          onTap: onPressed,
          child: Text(
            text2,
            style: AppStyles.styleMedium16(context).copyWith(color: AppColors.blue ),
          ),
        ),
      ],
    );

  }
}
