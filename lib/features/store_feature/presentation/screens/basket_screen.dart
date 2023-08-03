import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_badge.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_cachedimage.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_header.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/model/product_model.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/order_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/basket/basket_bloc.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/basket/basket_event.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/basket/basket_state.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/basket/basket_status.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<BasketBloc>(context).add(
      BasketSendRequestEvent(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<BasketBloc, BasketState>(
          builder: (context, state) {
            if (state.status is BasketLoadingStatus) {
              return const CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Text('Loading...'),
                  ),
                ],
              );
            }
            if (state.status is BasketSuccessStatus) {
              return Stack(
                children: <Widget>[
                  CustomScrollView(
                    slivers: <Widget>[
                      const CustomHeader(
                        title: 'سبد خرید',
                        backButton: false,
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.only(bottom: 90),
                        sliver: SliverGrid.builder(
                          itemCount: (state.status as BasketSuccessStatus)
                              .orders
                              .length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisExtent: 239,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 24,
                          ),
                          itemBuilder: (context, index) {
                            return BasketCart(
                              order: (state.status as BasketSuccessStatus)
                                  .orders[index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  CompleteBuyButton(
                      finalPrice:
                          (state.status as BasketSuccessStatus).payablePrice),
                ],
              );
            } else {
              return const CustomScrollView(
                slivers: [],
              );
            }
          },
        ),
      ),
    );
  }
}

class CompleteBuyButton extends StatelessWidget {
  final int finalPrice;
  const CompleteBuyButton({
    super.key,
    required this.finalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 24,
      left: 24,
      child: InkWell(
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: ConstantsColors.green,
            borderRadius: BorderRadiusDirectional.circular(15),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 2),
                color: ConstantsColors.green,
              ),
            ],
          ),
          child: Center(
            child: Text(
              '$finalPrice تومان - تکمیل فرایند خرید',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BasketCart extends StatelessWidget {
  final OrderEntity order;
  const BasketCart({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 16,
            offset: Offset(0, 5),
            color: Colors.grey,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 20,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: CustomCachedImage(
                      imageUrl: order.mainImageUrl,
                      fixed: true,
                      rounded: false,
                      loadingAnimation: true,
                    ),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          order.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          order.warranty,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: ConstantsColors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              order.realPrice.toString(),
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: ConstantsColors.grey,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CustomBadge(
                              percent: calcutePercent(
                                  realPrice: order.realPrice,
                                  discountPrice: order.discountPrice),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const DottedDashedLine(
            height: 1,
            width: double.infinity,
            axis: Axis.horizontal,
            dashColor: ConstantsColors.grey,
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                '${order.finalPrice} تومان',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
