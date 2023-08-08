import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/comments/comments_status.dart';

class CommentsState {
  final CommentsStatus status;
  CommentsState({required this.status});

  CommentsState setStatus({required CommentsStatus newStatus}) {
    if (newStatus != status) {
      return CommentsState(status: newStatus);
    } else {
      return CommentsState(status: status);
    }
  }
}
