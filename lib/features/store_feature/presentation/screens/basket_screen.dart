import 'package:flutter/material.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_badge.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_header.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            CustomScrollView(
              slivers: <Widget>[
                const CustomHeader(
                  title: 'سبد خرید',
                  backButton: false,
                ),
                SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisExtent: 239,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 24,
                  ),
                  itemBuilder: (context, index) {
                    return const BasketCart();
                  },
                )
              ],
            ),
            const CompleteBuyButton(),
          ],
        ),
      ),
    );
  }
}

class CompleteBuyButton extends StatelessWidget {
  const CompleteBuyButton({
    super.key,
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
          child: const Center(
            child: Text(
              '300,000,000 تومان - تکمیل فرایند خرید',
              style: TextStyle(
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
  const BasketCart({
    super.key,
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
                    child: Image.asset(
                      'assets/images/pro.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  const Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'اسم محصول',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'گارانتی فیلان و اینا',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: ConstantsColors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              '160,000,000  تومان',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: ConstantsColors.grey,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            CustomBadge(),
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
          const Expanded(
            flex: 2,
            child: Center(
              child: Text(
                '160,000,000 تومان',
                style: TextStyle(
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
