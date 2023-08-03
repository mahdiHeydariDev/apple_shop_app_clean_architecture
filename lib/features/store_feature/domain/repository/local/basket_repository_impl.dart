import 'package:dartz/dartz.dart';
import 'package:store_app_clean_architecture/core/constants/constants_text/api_text.dart';
import 'package:store_app_clean_architecture/core/utils/errors/api_error.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/core/utils/errors/uknown_exception.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/data_source/local/basket_data_source.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/repository/local/basket_repository.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/order_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_variant_entity.dart';

class BasketRepositoryImpl extends BasketRepository {
  final BasketDataSource dataSource;
  BasketRepositoryImpl({required this.dataSource});
  @override
  Future<Either<CustomError, String>> addToBasket({
    required ProductEntity product,
    required List<ProductVariantEntity> variants,
  }) async {
    try {
      final OrderEntity order = OrderEntity(
        id: product.id,
        name: product.name,
        warranty: 'گارانتی 18 ماهه اپل لند',
        mainImageUrl: product.thumbnail,
        realPrice: product.price,
        discountPrice: product.discountPrice,
        finalPrice: product.price + product.discountPrice,
        count: 1,
        productVariants: variants,
      );
      await dataSource.addToBasket(order: order);
      return const Right('Success');
    } on ApiEception catch (_) {
      return left(
        CustomError(
          header: ApiText.uknownHeader,
          description: ApiText.uknownDescription,
        ),
      );
    } on UknownError catch (_) {
      return left(
        CustomError(
          header: ApiText.uknownHeader,
          description: ApiText.uknownDescription,
        ),
      );
    } catch (_) {
      return left(
        CustomError(
          header: ApiText.uknownHeader,
          description: ApiText.uknownDescription,
        ),
      );
    }
  }

  @override
  Future<Either<CustomError, List<OrderEntity>>> getOrders() async {
    try {
      final List<OrderEntity> ordersResponse = await dataSource.getOrders();
      return Right(ordersResponse);
    } on ApiEception catch (_) {
      return Left(
        CustomError(
          header: ApiText.uknownHeader,
          description: ApiText.uknownDescription,
        ),
      );
    } catch (_) {
      return Left(
        CustomError(
          header: ApiText.uknownHeader,
          description: ApiText.uknownDescription,
        ),
      );
    }
  }
}