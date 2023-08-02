import 'package:flutter/material.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            CustomScrollView(
              slivers: <Widget>[
                const CustomHeader(title: 'حساب کاربری'),
                const SliverToBoxAdapter(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'محمد مهدی حیدری',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        '09214840491',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: ConstantsColors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  sliver: SliverGrid.builder(
                    itemCount: 10,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 20,
                    ),
                    itemBuilder: (context, index) {
                      return Column(
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
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                  color: ConstantsColors.blue,
                                  offset: Offset(0, 5),
                                )
                              ],
                              color: ConstantsColors.blue,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.settings_outlined,
                                color: Colors.white,
                                size: 45,
                              ),
                            ),
                          ),
                          const Text(
                            'تنظیمات',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            const Positioned(
              bottom: 15,
              child: Column(
                children: <Widget>[
                  Text('Powerd By MahdiFlutter'),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'VERSION 1.0.0',
                    style: TextStyle(
                      color: ConstantsColors.grey,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
