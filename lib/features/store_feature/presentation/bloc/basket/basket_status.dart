import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/order_entity.dart';

class BasketStatus {}

class BasketLoadingStatus extends BasketStatus {}

class BasketSuccessStatus extends BasketStatus {
  final List<OrderEntity> orders;
  final int payablePrice;
  BasketSuccessStatus({
    required this.orders,
    required this.payablePrice,
  });
}

class BasketFailedStatus extends BasketStatus {
  final CustomError error;
  BasketFailedStatus({
    required this.error,
  });
}
