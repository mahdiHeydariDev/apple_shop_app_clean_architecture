import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';

abstract class DataState<T> {
  final T? data;
  final CustomError? exception;
  DataState(this.data, this.exception);
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess({T? data}) : super(data, null);
}

class DataFailed extends DataState {
  DataFailed({CustomError? error}) : super(null, error);
}
