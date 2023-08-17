import 'package:flutter/material.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';

class ProfileItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function whenClick;
  const ProfileItem({
    super.key,
    required this.text,
    required this.icon,
    required this.whenClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        whenClick();
      },
      child: Column(
        children: <Widget>[
          Container(
            width: 56,
            height: 56,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: ShapeDecoration(
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(
                  40,
                ),
              ),
              shadows: const <BoxShadow>[
                BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 0.5,
                  color: ConstantsColors.blue,
                  offset: Offset(0, 2),
                )
              ],
              color: ConstantsColors.blue,
            ),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: 45,
              ),
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
