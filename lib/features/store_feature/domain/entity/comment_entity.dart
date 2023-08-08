import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String id;
  final String productId;
  final String text;
  final String userId;
  final String userAvatarUrl;
  final String userName;

  const CommentEntity({
    required this.id,
    required this.productId,
    required this.text,
    required this.userId,
    required this.userAvatarUrl,
    required this.userName,
  });

  @override
  List<Object?> get props => [
        id,
        productId,
        text,
        userId,
        userAvatarUrl,
        userName,
      ];
}
