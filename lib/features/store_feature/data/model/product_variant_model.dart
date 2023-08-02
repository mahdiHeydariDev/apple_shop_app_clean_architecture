import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_variant_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/variant_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/variant_type_entity.dart';

class ProductVariantModel extends ProductVariantEntity {
  const ProductVariantModel({
    required VariantTypeEntity variantType,
    required List<VariantEntity> variants,
  }) : super(
          variantType: variantType,
          variants: variants,
        );
}
