import 'package:store_app_clean_architecture/features/store_feature/domain/entity/order_entity.dart';

class BasketEvent {}

class BasketSendRequestEvent extends BasketEvent {}

class BasketIncreseOrderCount extends BasketEvent {
  final OrderEntity order;
  BasketIncreseOrderCount({required this.order});
}
