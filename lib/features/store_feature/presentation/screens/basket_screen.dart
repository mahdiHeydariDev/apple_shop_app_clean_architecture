import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';
import 'package:store_app_clean_architecture/core/utils/extentions/num_extentions.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_badge.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_cachedimage.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_header.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_loading.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/model/product_model.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/order_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/basket/basket_bloc.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/basket/basket_event.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/basket/basket_state.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/basket/basket_status.dart';
import 'package:zarinpal/zarinpal.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  final PaymentRequest _paymentRequest = PaymentRequest();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BasketBloc>(context).add(
      BasketSendRequestEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<BasketBloc, BasketState>(
          builder: (context, state) {
            if (state.status is BasketLoadingStatus) {
              return const CustomLoading();
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
                            mainAxisExtent: 270,
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
                        (state.status as BasketSuccessStatus).payablePrice,
                    payment: _paymentRequest,
                  ),
                ],
              );
            }
            if (state.status is BasketEmptyStatus) {
              return const CustomScrollView(
                slivers: <Widget>[
                  CustomHeader(title: 'سبد خرید'),
                  SliverToBoxAdapter(
                    child: EmptyWidget(),
                  ),
                ],
              );
            } else {
              return const CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Text('Error'),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 15,
          ),
          child: Image.asset(
            'assets/images/empty.png',
            width: double.infinity,
            height: 300,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'هیچ آیتمی در سبد خرید شما وجود ندارد',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: ConstantsColors.blue,
          ),
        ),
      ],
    );
  }
}

class CompleteBuyButton extends StatelessWidget {
  final int finalPrice;
  final PaymentRequest payment;
  const CompleteBuyButton({
    super.key,
    required this.finalPrice,
    required this.payment,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 24,
      left: 24,
      child: InkWell(
        onTap: () {
          BlocProvider.of<BasketBloc>(context).add(
            BasketPaymentRequestEvent(amount: finalPrice),
          );
        },
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: ConstantsColors.green,
            borderRadius: BorderRadiusDirectional.circular(15),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                spreadRadius: 0.5,
                blurRadius: 5,
                offset: Offset(0, 3),
                color: ConstantsColors.green,
              ),
            ],
          ),
          child: Center(
            child: Text(
              '${finalPrice.priceSeparator()} تومان - تکمیل فرایند خرید',
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
        color: Theme.of(context).cardColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            spreadRadius: 0.5,
            blurRadius: 5,
            offset: const Offset(0, 3),
            color: Theme.of(context).shadowColor,
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
                    flex: 2,
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
                              order.realPrice.priceSeparator(),
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
          const DottedDashedLine(
            height: 1,
            width: double.infinity,
            axis: Axis.horizontal,
            dashColor: ConstantsColors.grey,
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        BlocProvider.of<BasketBloc>(context).add(
                          BasketIncreseOrderCount(order: order),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(6),
                          color: ConstantsColors.green,
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              spreadRadius: 0.5,
                              blurRadius: 5,
                              color: ConstantsColors.green,
                              offset: Offset(0, 3),
                            )
                          ],
                        ),
                        child: const Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      order.count.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {
                        if (order.count == 1) {
                          BlocProvider.of<BasketBloc>(context).add(
                            BasketDeleteOrder(order: order),
                          );
                        } else {
                          BlocProvider.of<BasketBloc>(context).add(
                            BasketDecreseOrderCount(order: order),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: ConstantsColors.red,
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              spreadRadius: 0.5,
                              blurRadius: 5,
                              color: ConstantsColors.red,
                              offset: Offset(0, 3),
                            )
                          ],
                          borderRadius: BorderRadiusDirectional.circular(6),
                        ),
                        child: Icon(
                          order.count == 1
                              ? Icons.delete_outline_rounded
                              : Icons.remove_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${((order.finalPrice) * order.count).priceSeparator()} تومان',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
