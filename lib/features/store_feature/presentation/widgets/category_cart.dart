import 'package:flutter/material.dart';

class CategoryCart extends StatelessWidget {
  const CategoryCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
