import 'package:flutter/material.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';

class CustomBadge extends StatelessWidget {
  const CustomBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 20,
      decoration: BoxDecoration(
        color: ConstantsColors.red,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text(
          '%4',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
