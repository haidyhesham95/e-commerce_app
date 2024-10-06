import 'package:ecommerce_app/utils/style/color.dart';
import 'package:flutter/material.dart';

import '../../../utils/style/font_size.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({super.key,required this.controller, required this.validator , required this.keyboardType, this.labelText, this.hintText, this.suffixIcon, this.prefixIcon, this.onChanged, this.textInputAction, this.borderRadius, this.label,  this.obsecureText = false });
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String? labelText , hintText;
  final Widget? suffixIcon , prefixIcon;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final double? borderRadius;
  final String? label;
  final bool obsecureText ;

  @override
  Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        if (label != null)
    Text(label!,
        style:   AppStyles.styleMedium16(context)),
    const SizedBox(height: 10),
    TextFormField(
      controller:controller ,
      validator:validator,
      keyboardType:keyboardType ,
      onChanged:onChanged,
      textInputAction: textInputAction ,
      obscureText: obsecureText,
      decoration: InputDecoration(
        fillColor: Colors.grey[200],
        alignLabelWithHint: true,
        labelText: labelText,
        hintText: hintText,


        hintStyle: AppStyles.styleMedium15(context).copyWith(color: Colors.grey),

        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.gray,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          borderSide: BorderSide(
            color: AppColors.gray,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          borderSide: BorderSide(
            color:AppColors.gray,
            width: 0.5,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          borderSide: BorderSide(
            color: AppColors.gray,
            width: 0.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 0.5,
          ),
        ),
        errorStyle: const TextStyle(color: Colors.red),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 0.5,
          ),
        ),
        suffixIcon: suffixIcon,
        suffixIconColor: Colors.grey,
        prefixIcon: prefixIcon,

        filled: true,
      ),
    )
    ],
          );
  }
}
