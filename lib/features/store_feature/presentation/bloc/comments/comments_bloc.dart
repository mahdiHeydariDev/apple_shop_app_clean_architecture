import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/comment_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/comments_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/comments/comments_event.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/comments/comments_state.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/comments/comments_status.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final CommentsUseCase useCase;
  CommentsBloc({required this.useCase})
      : super(
          CommentsState(
            status: CommentsLoadingStatus(),
          ),
        ) {
    on<CommentsSendRequestEvent>((event, emit) async {
      emit(
        state.setStatus(
          newStatus: CommentsLoadingStatus(),
        ),
      );
      final Either<CustomError, List<CommentEntity>> commentsResponse =
          await useCase.getComments(
        productId: event.productId,
      );
      if (commentsResponse.isRight()) {
        List<CommentEntity> comments = [];
        commentsResponse.fold(
            (l) => null, (commentsSuccess) => comments = commentsSuccess);
        emit(
          state.setStatus(
            newStatus: comments.isEmpty
                ? CommentsResponseEmptyStatus()
                : CommentsResponseStatus(comments: comments),
          ),
        );
      } else {
        CustomError? error;
        commentsResponse.fold((errorText) => error = errorText, (r) => null);
        emit(
          state.setStatus(
            newStatus: CommentsErrorStatus(error: error!),
          ),
        );
      }
    });
  }
}
