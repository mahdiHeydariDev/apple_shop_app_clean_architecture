import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:store_app_clean_architecture/core/utils/errors/api_error.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/data_source/category_data_source.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/repository/categories_repository.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/category_entity.dart';

class CategoriesRepositoryImpl extends CategoriesRepository {
  final CategoryDataSource dataSource;
  CategoriesRepositoryImpl({required this.dataSource});
  @override
  Future<Either<CustomError, List<CategoryEntity>>> getAllCategories() async {
    try {
      //not completed
      //TODO Searching for a way to automatically create lists
      final Response datasourceResponse = await dataSource.getAllCategories();
      if (datasourceResponse.statusCode == 200) {
        final List<BannerModel> bannersList =
            (responseDataSource.data['items'] as List)
                .map<BannerModel>(
                  (element) => BannerModel.fromMapJson(element),
                )
                .toList();

        return Right(bannersList);
      } else {}
    } on ApiEception catch (_) {
    } catch (_) {}
  }
}
