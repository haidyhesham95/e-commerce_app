import 'package:flutter/material.dart';

import '../../../core/utils/style/color.dart';
import '../../../core/utils/style/font_size.dart';

class SeeAllText extends StatelessWidget {
  const SeeAllText({
    super.key,
    required this.text,
    required this.showAll,
    required this.onToggle,
  });

  final String text;
  final bool showAll;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: AppStyles.styleMedium18(context),
        ),
        TextButton(
          onPressed: onToggle,
          child: Text(
            showAll ? 'Show Less' : 'See All',
            style: const TextStyle(color: AppColors.blue),
          ),
        ),
      ],
    );
  }
}
