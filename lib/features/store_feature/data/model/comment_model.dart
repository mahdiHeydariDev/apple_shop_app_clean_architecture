import 'package:store_app_clean_architecture/features/store_feature/domain/entity/comment_entity.dart';

class CommentModel extends CommentEntity {
  const CommentModel({
    required String id,
    required String productId,
    required String text,
    required String userId,
  }) : super(
          id: id,
          productId: productId,
          text: text,
          userId: userId,
        );

  factory CommentModel.fromMapJson(Map<String, dynamic> mapJson) {
    return CommentModel(
      id: mapJson['id'],
      productId: mapJson['product_id'],
      text: mapJson['text'],
      userId: mapJson['user_id'],
    );
  }
}
