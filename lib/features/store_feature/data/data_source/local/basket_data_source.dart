import 'package:hive_flutter/hive_flutter.dart';
import 'package:store_app_clean_architecture/core/utils/errors/api_error.dart';
import 'package:store_app_clean_architecture/core/utils/errors/uknown_exception.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/order_entity.dart';

class BasketDataSource {
  final Box<OrderEntity> _ordersBox;
  BasketDataSource(this._ordersBox);
  //get all orders from basket
  Future<List<OrderEntity>> getOrders() async {
    try {
      final List<OrderEntity> response = _ordersBox.values.toList();
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
      await _ordersBox.add(order);
    } on HiveError catch (exception) {
      throw ApiEception(
        exceptionMessage: exception.message,
        exceptionCode: 0,
      );
    } catch (uknownException) {
      throw UknownError();
    }
  }

  //Increase Count of the Order
  Future<void> increseOrderCount({required OrderEntity selectedOrder}) async {
    try {
      final List<OrderEntity> allOrders = _ordersBox.values.toList();
      for (var order in allOrders) {
        if (order.id == selectedOrder.id) {
          order.count = order.count + 1;
        }
      }
      await _ordersBox.clear();
      for (var order in allOrders) {
        await _ordersBox.add(order);
      }
    } on HiveError catch (exception) {
      throw ApiEception(
        exceptionMessage: exception.message,
        exceptionCode: 0,
      );
    } catch (anotherException) {
      throw UknownError();
    }
  }

  //Dencrease Count of the Order
  Future<void> decreseOrderCount({required OrderEntity selectedOrder}) async {
    try {
      final List<OrderEntity> allOrders = _ordersBox.values.toList();
      for (var order in allOrders) {
        if (order.id == selectedOrder.id) {
          order.count = order.count - 1;
        }
      }
      await _ordersBox.clear();
      for (var order in allOrders) {
        await _ordersBox.add(order);
      }
    } on HiveError catch (exception) {
      throw ApiEception(
        exceptionMessage: exception.message,
        exceptionCode: 0,
      );
    } catch (anotherException) {
      throw UknownError();
    }
  }

  //Delete the Order
  Future<void> deleteOrder({required OrderEntity selectedOrder}) async {
    try {
      final List<OrderEntity> allOrders = _ordersBox.values.toList();
      final int selectedindex = allOrders.indexOf(selectedOrder);

      await _ordersBox.deleteAt(selectedindex);
    } on HiveError catch (exception) {
      throw ApiEception(
        exceptionMessage: exception.message,
        exceptionCode: 0,
      );
    } catch (anotherException) {
      throw UknownError();
    }
  }
}
