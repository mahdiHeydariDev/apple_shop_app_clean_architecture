class CommentsEvent {}

class CommentsSendRequestEvent extends CommentsEvent {
  final String productId;
  CommentsSendRequestEvent({required this.productId});
}
