import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/comment_entity.dart';

class CommentsStatus {}

class CommentsLoadingStatus extends CommentsStatus {}

class CommentsResponseStatus extends CommentsStatus {
  final List<CommentEntity> comments;
  CommentsResponseStatus({required this.comments});
}

class CommentsResponseEmptyStatus extends CommentsStatus {}

class CommentsErrorStatus extends CommentsStatus {
  final CustomError error;
  CommentsErrorStatus({required this.error});
}
