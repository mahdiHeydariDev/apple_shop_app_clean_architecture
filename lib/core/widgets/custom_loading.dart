import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const SizedBox(
          width: double.infinity,
        ),
        LoadingAnimationWidget.inkDrop(
          color: ConstantsColors.blue,
          size: 60,
        ),
        const SizedBox(
          height: 40,
        ),
        const Text(
          'در حال دریافت اطلاعات از سرور...',
        ),
      ],
    );
  }
}
