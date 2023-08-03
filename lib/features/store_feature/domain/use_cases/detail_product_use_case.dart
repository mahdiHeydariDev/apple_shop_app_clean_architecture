import 'package:dartz/dartz.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_variant_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/property_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/repository/remote/detail_product_repository_impl.dart';

class DetailProductUsecase {
  final DetailProductRepositoryImpl repository;
  DetailProductUsecase({required this.repository});
  Future<Either<CustomError, List<ProductVariantEntity>>> callGetVariants({
    required String productId,
  }) async {
    return await repository.getProductVariants(productId: productId);
  }

  Future<Either<CustomError, List<PropertyEntity>>> callGetProperties({
    required String productId,
  }) async {
    return await repository.getProperties(productId: productId);
  }
}
