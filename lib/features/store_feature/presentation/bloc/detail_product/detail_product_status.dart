import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/category_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/gallery_image_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_variant_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/property_entity.dart';

class DetailProductStatus {}

class DetailProductLoadingStatus extends DetailProductStatus {}

class DetailProductSuccessStatus extends DetailProductStatus {
  final CategoryEntity category;
  final List<GalleryImageEntity> galleryImages;
  final List<ProductVariantEntity> productVariants;
  final List<PropertyEntity> properties;

  DetailProductSuccessStatus({
    required this.category,
    required this.galleryImages,
    required this.productVariants,
    required this.properties,
  });
}

class DetailProductFailedStatus extends DetailProductStatus {
  final CustomError error;

  DetailProductFailedStatus({required this.error});
}
