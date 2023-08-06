import 'package:store_app_clean_architecture/features/store_feature/domain/entity/order_entity.dart';

class BasketEvent {}

class BasketSendRequestEvent extends BasketEvent {}

//ZarinPal Payment
class BasketPaymentRequestEvent extends BasketEvent {
  final num amount;
  BasketPaymentRequestEvent({
    required this.amount,
  });
}

class BasketIncreseOrderCount extends BasketEvent {
  final OrderEntity order;
  BasketIncreseOrderCount({required this.order});
}

class BasketDecreseOrderCount extends BasketEvent {
  final OrderEntity order;
  BasketDecreseOrderCount({required this.order});
}

class BasketDeleteOrder extends BasketEvent {
  final OrderEntity order;
  BasketDeleteOrder({required this.order});
}
