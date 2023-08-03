import 'package:hive_flutter/hive_flutter.dart';
import 'package:store_app_clean_architecture/core/utils/errors/api_error.dart';
import 'package:store_app_clean_architecture/core/utils/errors/uknown_exception.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/order_entity.dart';

class BasketDataSource {
  final Box<OrderEntity> ordersBox;
  BasketDataSource({required this.ordersBox});
  //get all orders from basket
  Future<List<OrderEntity>> getOrders() async {
    try {
      final List<OrderEntity> response = ordersBox.values.toList();
      return response;
    } on HiveError catch (exception) {
      throw ApiEception(
        exceptionMessage: exception.message,
        exceptionCode: 0,
      );
    } catch (uknownException) {
      throw UknownError();
    }
  }

  //add a product to user basket
  Future<void> addToBasket({required OrderEntity order}) async {
    try {
      await ordersBox.add(order);
    } on HiveError catch (exception) {
      throw ApiEception(
        exceptionMessage: exception.message,
        exceptionCode: 0,
      );
    } catch (uknownException) {
      throw UknownError();
    }
  }
}
