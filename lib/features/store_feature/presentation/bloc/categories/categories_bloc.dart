import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/category_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/categories_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/categories/categories_event.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/categories/categories_state.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/categories/categories_status.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesUsecase categoriesUsecase;
  CategoriesBloc({required this.categoriesUsecase})
      : super(
          CategoriesState(
            status: CategoriesLoadingStatus(),
          ),
        ) {
    on<CategoriesSendRequestEvent>(
      (event, emit) async {
        emit(
          state.setStatus(
            newStatus: CategoriesLoadingStatus(),
          ),
        );
        final Either<CustomError, List<CategoryEntity>> categoriesResponse =
            await categoriesUsecase.callAllCategories();

        if (categoriesResponse.isRight()) {
          List<CategoryEntity> categoriesList = [];
          categoriesResponse.fold(
            (l) => null,
            (r) => categoriesList = r,
          );
          emit(
            state.setStatus(
              newStatus:
                  CategoriesSuccessStatus(categoriesResponse: categoriesList),
            ),
          );
        } else {
          CustomError? error;
          categoriesResponse.fold(
            (customError) => error = customError,
            (r) => null,
          );
          emit(
            state.setStatus(
              newStatus: CategoriesFailedStatus(
                error: error!,
              ),
            ),
          );
        }
      },
    );
  }
}
