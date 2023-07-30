import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:store_app_clean_architecture/core/constants/constants_api.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/data_source/banners_data_source.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/data_source/category_data_source.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/data_source/products_data_source.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/repository/banners_repository_impl.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/repository/categories_repository_impl.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/repository/products_repository_impl.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/banners_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/categories_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/products_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/home/home_bloc.dart';

var serviceLocator = GetIt.instance;
Future<void> initGeiIt() async {
  //dio
  serviceLocator.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: ConstantsApi.baseUrl,
      ),
    ),
  );
  //data sources
  serviceLocator.registerSingleton<BannersDataSource>(
    BannersDataSource(
      dio: serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<CategoryDataSource>(
    CategoryDataSource(
      dio: serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<ProductsDataSource>(
    ProductsDataSource(
      dio: serviceLocator.get(),
    ),
  );
  //repositories
  serviceLocator.registerSingleton<BannersRepositoryImpl>(
    BannersRepositoryImpl(
      dataSource: serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<CategoriesRepositoryImpl>(
    CategoriesRepositoryImpl(
      dataSource: serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<ProductsRepositoryImpl>(
    ProductsRepositoryImpl(
      dataSource: serviceLocator.get(),
    ),
  );
  //use cases,
  serviceLocator.registerSingleton<BannersUseCase>(
    BannersUseCase(
      repository: serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<CategoriesUsecase>(
    CategoriesUsecase(
      repository: serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<ProductsUsecase>(
    ProductsUsecase(
      repository: serviceLocator.get(),
    ),
  );
  //Bloc
  serviceLocator.registerSingleton<HomeBloc>(
    HomeBloc(
      bannersUsecase: serviceLocator.get(),
      categoriesUsecase: serviceLocator.get(),
      productsUsecase: serviceLocator.get(),
    ),
  );
}
