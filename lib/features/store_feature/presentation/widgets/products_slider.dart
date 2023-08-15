import 'package:flutter/material.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';
import 'package:store_app_clean_architecture/core/widgets/product_cart.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_entity.dart';

class ProductsSlider extends StatelessWidget {
  final String title;
  final List<ProductEntity> products;
  const ProductsSlider({
    super.key,
    required this.title,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              right: 24,
              left: 24,
              top: 32,
              bottom: 20,
            ),
            child: Row(
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: ConstantsColors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                const Text(
                  'مشاهده همه',
                  style: TextStyle(
                    color: ConstantsColors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: ConstantsColors.blue,
                )
              ],
            ),
          ),
          SizedBox(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.only(right: 14),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCart(
                    product: products[index],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
