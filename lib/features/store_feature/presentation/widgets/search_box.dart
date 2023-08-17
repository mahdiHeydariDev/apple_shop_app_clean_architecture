import 'package:flutter/material.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';

class CustomSearchBox extends StatelessWidget {
  const CustomSearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        vertical: 32,
        horizontal: 24,
      ),
      sliver: SliverToBoxAdapter(
        child: Container(
          width: double.infinity,
          height: 46.0,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 0.5,
                offset: const Offset(
                  0,
                  3,
                ),
                color: Theme.of(context).shadowColor,
              ),
            ],
          ),
          child: const Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  right: 15,
                  left: 10,
                ),
                child: Icon(
                  Icons.search,
                  color: ConstantsColors.grey,
                  size: 25,
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'جستجو در محصولات',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 10,
                ),
                child: Icon(
                  Icons.apple,
                  color: ConstantsColors.blue,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
