import 'package:store_app_clean_architecture/features/store_feature/domain/entity/comment_entity.dart';

class CommentModel extends CommentEntity {
  const CommentModel({
    required String id,
    required String productId,
    required String text,
    required String userId,
    required String userAvatarUrl,
    required String userName,
  }) : super(
          id: id,
          productId: productId,
          text: text,
          userId: userId,
          userAvatarUrl: userAvatarUrl,
          userName: userName,
        );

  factory CommentModel.fromMapJson(Map<String, dynamic> mapJson) {
    return CommentModel(
      id: mapJson['id'],
      productId: mapJson['product_id'],
      text: mapJson['text'],
      userId: mapJson['user_id'],
      userAvatarUrl: mapJson['expand']['user_id']['avatar'] == ''
          ? 'https://www.pngkit.com/png/detail/202-2024644_profile-icon-profile-color-icon-png.png'
          : 'http://startflutter.ir/api/files/${mapJson['expand']['user_id']['collectionName']}/${mapJson['expand']['user_id']['id']}/${mapJson['expand']['user_id']['avatar']}',
      userName: mapJson['expand']['user_id']['name'],
    );
  }
}
