import 'package:flutter/material.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';
import 'package:store_app_clean_architecture/core/widgets/product_cart.dart';

class ProductsSlider extends StatelessWidget {
  const ProductsSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(
              right: 24,
              left: 24,
              top: 32,
              bottom: 20,
            ),
            child: Row(
              children: <Widget>[
                Text(
                  'پرفروش ترین ها🔥',
                  style: TextStyle(
                    color: ConstantsColors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                Text(
                  'مشاهده همه',
                  style: TextStyle(
                    color: ConstantsColors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: ConstantsColors.blue,
                )
              ],
            ),
          ),
          SizedBox(
            height: 266.0,
            child: Padding(
              padding: const EdgeInsets.only(right: 14),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return const ProductCart();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
