import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';
import 'package:store_app_clean_architecture/core/utils/extentions/num_extentions.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_badge.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_cachedimage.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/basket/basket_bloc.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/screens/detail_product_screen.dart';
import 'package:store_app_clean_architecture/service_locator.dart';

class ProductCart extends StatelessWidget {
  final ProductEntity product;
  const ProductCart({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: serviceLocator.get<BasketBloc>(),
              child: DetailProductScreen(product: product),
            ),
          ),
        );
      },
      child: Column(
        children: <Widget>[
          Container(
            width: 160.0,
            height: 216.0,
            margin: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: <Widget>[
                //Header cart (product image)
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SizedBox(
                    width: double.infinity,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        SizedBox(
                          width: 90,
                          height: 104,
                          child: CustomCachedImage(
                            imageUrl: product.thumbnail,
                            fixed: false,
                            rounded: false,
                          ),
                        ),
                        const Positioned(
                          top: 0,
                          right: 10,
                          child: Icon(
                            Icons.bookmark_add_outlined,
                            color: ConstantsColors.blue,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 10,
                          child: CustomBadge(
                            percent: product.percent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //middle cart (product name)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),

                //Footer cart (product price info)
                Container(
                  height: 53,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: ConstantsColors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: ConstantsColors.blue,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.chevron_left_rounded,
                        color: Colors.white,
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Text>[
                          Text(
                            product.price.priceSeparator(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Text(
                            product.realPrice.priceSeparator(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Text(
                        'تومان',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
