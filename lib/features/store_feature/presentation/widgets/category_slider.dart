import 'package:flutter/material.dart';
import 'package:store_app_clean_architecture/core/constants/constant_colors.dart';
import 'package:store_app_clean_architecture/core/utils/extentions/string_extentions.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_cachedimage.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/category_entity.dart';

class CategorySlider extends StatelessWidget {
  final List<CategoryEntity> categories;
  const CategorySlider({super.key, required this.categories});

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
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryBox(
                    category: categories[index],
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

class CategoryBox extends StatelessWidget {
  final CategoryEntity category;
  const CategoryBox({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
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
            color: Color(category.color.convertToColor()),
            shadows: <BoxShadow>[
              BoxShadow(
                color: Color(category.color.convertToColor()),
                blurRadius: 5,
                spreadRadius: 0.5,
                offset: const Offset(
                  0,
                  3,
                ),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 26,
                height: 26,
                child: CustomCachedImage(
                  imageUrl: category.icon,
                  loadingAnimation: false,
                  rounded: false,
                  fixed: true,
                ),
              ),
            ],
          ),
        ),
        Text(
          category.title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
