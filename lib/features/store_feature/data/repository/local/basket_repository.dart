import 'package:dartz/dartz.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/order_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_variant_entity.dart';

abstract class BasketRepository {
  Future<Either<CustomError, String>> addToBasket({
    required ProductEntity product,
    required List<ProductVariantEntity> variants,
  });
  Future<Either<CustomError, List<OrderEntity>>> getOrders();
  Future<void> increaseOrderCount({required OrderEntity selectedOrder});
  Future<void> decreaseOrderCount({required OrderEntity selectedOrder});
  Future<void> deleteOrder({required OrderEntity selectedOrder});
}
