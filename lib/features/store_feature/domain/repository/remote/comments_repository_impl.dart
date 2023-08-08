import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:store_app_clean_architecture/core/constants/constants_text/api_text.dart';
import 'package:store_app_clean_architecture/core/utils/errors/api_error.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/core/utils/errors/uknown_exception.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/data_source/remote/comments_data_source.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/model/comment_model.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/repository/remote/comments_repository.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/comment_entity.dart';

class CommentsRepositoryImpl extends CommentsRepository {
  final CommentsDataSource dataSource;
  CommentsRepositoryImpl({required this.dataSource});
  @override
  Future<Either<CustomError, List<CommentEntity>>> getAllComments(
      {required String productId}) async {
    try {
      final Response dataSourceResponse =
          await dataSource.getComments(productId: productId);
      if (dataSourceResponse.statusCode == 200) {
        final List<CommentEntity> commentsList =
            (dataSourceResponse.data['items'] as List)
                .map<CommentEntity>(
                  (mapJson) => CommentModel.fromMapJson(mapJson),
                )
                .toList();
        return Right(commentsList);
      } else {
        return Left(
          CustomError(
            header: ApiText.networkHeader,
            description: ApiText.networkDescription,
          ),
        );
      }
    } on ApiEception catch (_) {
      return Left(
        CustomError(
          header: ApiText.networkHeader,
          description: ApiText.networkDescription,
        ),
      );
    } on UknownError catch (_) {
      return Left(
        CustomError(
          header: ApiText.uknownHeader,
          description: ApiText.uknownDescription,
        ),
      );
    } catch (_) {
      return Left(
        CustomError(
          header: ApiText.uknownHeader,
          description: ApiText.uknownDescription,
        ),
      );
    }
  }
}
