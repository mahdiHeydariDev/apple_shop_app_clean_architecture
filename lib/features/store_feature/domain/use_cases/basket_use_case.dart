import 'package:dartz/dartz.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/order_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_variant_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/repository/local/basket_repository_impl.dart';

class BasketUsecase {
  final BasketRepositoryImpl repository;
  BasketUsecase({required this.repository});
  Future<Either<CustomError, String>> callAddToBasket({
    required ProductEntity product,
    required List<ProductVariantEntity> variants,
  }) async {
    return await repository.addToBasket(
      product: product,
      variants: variants,
    );
  }

  Future<Either<CustomError, List<OrderEntity>>> callGetorders() async {
    return await repository.getOrders();
  }

  Future<void> increaseOrderCount({required OrderEntity selectedOrder}) async {
    await repository.increaseOrderCount(selectedOrder: selectedOrder);
  }
}
