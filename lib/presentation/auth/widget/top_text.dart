import 'package:flutter/material.dart';

Column buildTopText(BuildContext context, {required String title, required String subtitle}) {
  return  Column(
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 5),
      Text(
       subtitle,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black45,
        ),
      ),
    ],
  );
}