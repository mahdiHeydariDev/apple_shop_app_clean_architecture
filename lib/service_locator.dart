import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:store_app_clean_architecture/core/constants/constants_api.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/data_source/local/basket_data_source.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/data_source/remote/banners_data_source.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/data_source/remote/category_data_source.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/data_source/remote/detail_product_data_source.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/data_source/remote/gallery_product_data_source.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/data_source/remote/products_data_source.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/order_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/repository/local/basket_repository_impl.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/repository/remote/banners_repository_impl.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/repository/remote/categories_repository_impl.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/repository/remote/detail_product_repository_impl.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/repository/remote/gallery_product_repository_impl.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/repository/remote/products_repository_impl.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/banners_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/basket_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/categories_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/detail_product_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/gallery_image_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/products_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/basket/basket_bloc.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/categories/categories_bloc.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/detail_product/detail_product_bloc.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/home/home_bloc.dart';

var serviceLocator = GetIt.instance;
Future<void> initGeiIt() async {
  //Hive
  serviceLocator.registerSingleton<Box<OrderEntity>>(
    Hive.box<OrderEntity>('orders'),
  );
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
  serviceLocator.registerSingleton<GalleryProductDataSource>(
    GalleryProductDataSource(
      dio: serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<DetailProductDatasource>(
    DetailProductDatasource(
      dio: serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<BasketDataSource>(
    BasketDataSource(
      ordersBox: serviceLocator.get(),
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
  serviceLocator.registerSingleton<GalleryProductRepositoryImpl>(
    GalleryProductRepositoryImpl(
      dataSource: serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<DetailProductRepositoryImpl>(
    DetailProductRepositoryImpl(
      dataSource: serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<BasketRepositoryImpl>(
    BasketRepositoryImpl(
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
  serviceLocator.registerSingleton<GalleryImagesUsecase>(
    GalleryImagesUsecase(
      repository: serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<DetailProductUsecase>(
    DetailProductUsecase(
      repository: serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<BasketUsecase>(
    BasketUsecase(
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
  serviceLocator.registerSingleton<CategoriesBloc>(
    CategoriesBloc(
      categoriesUsecase: serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<DetailProductBloc>(
    DetailProductBloc(
      categoryUsecase: serviceLocator.get(),
      galleryImageUsecase: serviceLocator.get(),
      detailProductUsecase: serviceLocator.get(),
      basketUsecase: serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<BasketBloc>(
    BasketBloc(
      basketUsecase: serviceLocator.get(),
    ),
  );
}
