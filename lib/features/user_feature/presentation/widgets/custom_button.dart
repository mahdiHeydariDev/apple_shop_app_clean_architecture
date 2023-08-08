import 'package:flutter/material.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function whenClick;
  const CustomButton({
    super.key,
    required this.text,
    required this.whenClick,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ConstantsColors.blue,
          ),
          onPressed: () {
            whenClick();
          },
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
