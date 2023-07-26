import 'package:flutter/material.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';

class DropDowBox extends StatelessWidget {
  const DropDowBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 20),
      sliver: SliverToBoxAdapter(
        child: Container(
          width: double.infinity,
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: ConstantsColors.grey,
            ),
          ),
          child: const Row(
            children: <Widget>[
              SizedBox(
                width: 15,
              ),
              Text(
                'توضیحات محصول',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Text(
                'مشاهده',
                style: TextStyle(
                  color: ConstantsColors.blue,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.arrow_drop_down_circle_outlined,
                color: ConstantsColors.blue,
              ),
              SizedBox(
                width: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
