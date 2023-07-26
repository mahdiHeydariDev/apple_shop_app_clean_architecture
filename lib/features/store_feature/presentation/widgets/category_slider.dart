import 'package:flutter/material.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';

class CategorySlider extends StatelessWidget {
  const CategorySlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: <Widget>[
                Text(
                  'دسته بندی',
                  style: TextStyle(
                    color: ConstantsColors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          SizedBox(
            height: 112,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 14,
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Container(
                        width: 56,
                        height: 56,
                        margin: const EdgeInsets.only(
                          left: 10,
                          top: 20,
                          bottom: 10,
                          right: 10,
                        ),
                        decoration: ShapeDecoration(
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          color: ConstantsColors.green,
                          shadows: const <BoxShadow>[
                            BoxShadow(
                              color: ConstantsColors.green,
                              blurRadius: 7,
                              spreadRadius: 1,
                              offset: Offset(
                                0,
                                1,
                              ),
                            )
                          ],
                        ),
                      ),
                      const Text(
                        'آیفون',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
