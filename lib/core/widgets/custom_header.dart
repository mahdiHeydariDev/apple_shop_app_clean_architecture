import 'package:flutter/material.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    super.key,
    required this.title,
    this.backButton = false,
  });
  final String title;
  final bool backButton;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 32,
        right: 24,
        left: 24,
      ),
      sliver: SliverToBoxAdapter(
        child: Container(
          width: double.infinity,
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadiusDirectional.circular(15),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: ConstantsColors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Positioned(
                right: 15,
                child: Icon(
                  Icons.apple,
                  color: ConstantsColors.blue,
                  size: 30,
                ),
              ),
              //Some pages dont need back button!.so we use it for resolve this problem.
              backButton
                  ? Positioned(
                      left: 5,
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: ConstantsColors.blue,
                          size: 20,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
