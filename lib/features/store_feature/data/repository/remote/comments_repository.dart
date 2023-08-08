import 'package:dartz/dartz.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/comment_entity.dart';

abstract class CommentsRepository {
  Future<Either<CustomError, List<CommentEntity>>> getAllComments({
    required String productId,
  });
}
