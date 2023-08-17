import 'package:dartz/dartz.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/repository/remote/comments_repository.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/comment_entity.dart';

class CommentsUseCase {
  final CommentsRepository _repository;
  CommentsUseCase({required CommentsRepository repository})
      : _repository = repository;
  Future<Either<CustomError, List<CommentEntity>>> getComments(
      {required String productId}) async {
    return await _repository.getAllComments(productId: productId);
  }
}
