import 'package:flutter/material.dart';
import 'package:store_app_clean_architecture/core/widgets/custom_cachedimage.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/category_entity.dart';

class CategoryCart extends StatelessWidget {
  final CategoryEntity category;
  const CategoryCart({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCachedImage(
      imageUrl: category.thumbnail,
    );
  }
}
