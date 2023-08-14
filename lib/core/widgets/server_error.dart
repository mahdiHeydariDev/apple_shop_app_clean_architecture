import 'package:flutter/material.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';
import 'package:store_app_clean_architecture/core/constants/constants_text/api_text.dart';

class ServerError extends StatelessWidget {
  const ServerError({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/images/failed.png',
            width: 100,
            height: 100,
          ),
          const Text(
            ApiText.serverErrorHeader,
            style: TextStyle(
              color: ConstantsColors.blue,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            ApiText.serverErrorDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ConstantsColors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
