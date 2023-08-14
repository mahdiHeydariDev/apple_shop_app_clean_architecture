import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/banner_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/category_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_entity.dart';

class HomeStatus {}

class HomeInitStatus extends HomeStatus {}

class HomeLoadingStatus extends HomeStatus {}

class HomeNotConnectionStatus extends HomeStatus {}

class HomeSuccessStatus extends HomeStatus {
  final List<BannerEntity> banners;
  final List<CategoryEntity> categories;
  final List<ProductEntity> hotestProducts;
  final List<ProductEntity> bestSellerProducts;
  HomeSuccessStatus({
    required this.banners,
    required this.categories,
    required this.hotestProducts,
    required this.bestSellerProducts,
  });
}

class HomeFailedStatus extends HomeStatus {
  final CustomError error;
  HomeFailedStatus({
    required this.error,
  });
}
