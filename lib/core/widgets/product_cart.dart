import 'package:flutter/material.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_badge.dart';

class ProductCart extends StatelessWidget {
  const ProductCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        width: 80,
                        height: 104,
                        child: Image.asset(
                          'assets/images/pro.png',
                          fit: BoxFit.cover,
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
                      const Positioned(
                        bottom: 0,
                        left: 10,
                        child: CustomBadge(),
                      ),
                    ],
                  ),
                ),
              ),
              //middle cart (product name)
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Text(
                  'آیفون ۱۳ پرومکس',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
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
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.chevron_left_rounded,
                      color: Colors.white,
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Text>[
                        Text(
                          '12,000',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          '12,000,000',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      'تومان',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
