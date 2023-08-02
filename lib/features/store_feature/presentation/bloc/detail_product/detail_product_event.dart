class DetailProductEvent {}

class DetailProductSendRequestEvent extends DetailProductEvent {
  final String id;
  final String productId;
  DetailProductSendRequestEvent({
    required this.id,
    required this.productId,
  });
}
