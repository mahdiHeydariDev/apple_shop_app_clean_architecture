import 'package:dartz/dartz.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_variant_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/property_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/variant_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/variant_type_entity.dart';

abstract class DetailProductRepository {
  Future<List<VariantTypeEntity>> getAllVariantTypes();
  Future<List<VariantEntity>> getVariants({
    required String productId,
  });
  Future<Either<CustomError, List<ProductVariantEntity>>> getProductVariants({
    required String productId,
  });
  Future<Either<CustomError, List<PropertyEntity>>> getProperties({
    required String productId,
  });
}
