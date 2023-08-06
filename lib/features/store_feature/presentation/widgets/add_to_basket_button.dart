import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_variant_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/basket/basket_bloc.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/basket/basket_event.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/detail_product/detail_product_bloc.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/detail_product/detail_product_event.dart';

class AddToBasketButton extends StatelessWidget {
  final ProductEntity product;
  final bool isInBasket;
  const AddToBasketButton({
    super.key,
    required this.product,
    required this.isInBasket,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (isInBasket == false) {
            BlocProvider.of<DetailProductBloc>(context).add(
              DetailProductAddToBasketEvent(
                product: product,
                variants: <ProductVariantEntity>[],
              ),
            );
            BlocProvider.of<BasketBloc>(context).add(
              BasketSendRequestEvent(),
            );
          }
        },
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            Container(
              width: 140,
              height: 60,
              decoration: BoxDecoration(
                color: ConstantsColors.blue,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 15,
                  sigmaY: 15,
                ),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      isInBasket ? 'در سبد خرید موجود میباشد' : 'افزودن به سبد',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: isInBasket ? 12 : 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
