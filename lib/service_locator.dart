import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app_clean_architecture/core/bloc/theme/theme_bloc.dart';
import 'package:store_app_clean_architecture/core/constants/constants_api.dart';
import 'package:store_app_clean_architecture/core/utils/payment_handler.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/data_source/local/basket_data_source.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/data_source/remote/banners_data_source.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/data_source/remote/category_data_source.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/data_source/remote/comments_data_source.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/data_source/remote/detail_product_data_source.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/data_source/remote/gallery_product_data_source.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/data_source/remote/products_data_source.dart';
import 'package:store_app_clean_architecture/features/store_feature/data/repository/remote/comments_repository.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/order_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/repository/local/basket_repository_impl.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/repository/remote/banners_repository_impl.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/repository/remote/categories_repository_impl.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/repository/remote/comments_repository_impl.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/repository/remote/detail_product_repository_impl.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/repository/remote/gallery_product_repository_impl.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/repository/remote/products_repository_impl.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/banners_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/basket_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/categories_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/comments_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/detail_product_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/gallery_image_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/products_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/basket/basket_bloc.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/categories/categories_bloc.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/comments/comments_bloc.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/detail_product/detail_product_bloc.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/home/home_bloc.dart';
import 'package:store_app_clean_architecture/features/user_feature/data/data_source/remote/login_user_data_source.dart';
import 'package:store_app_clean_architecture/features/user_feature/data/data_source/remote/register_user_data_source.dart';
import 'package:store_app_clean_architecture/features/user_feature/data/repository/remote/login_user_repository.dart';
import 'package:store_app_clean_architecture/features/user_feature/data/repository/remote/register_user_repository.dart';
import 'package:store_app_clean_architecture/features/user_feature/domain/repository/login_user_repository_impl.dart';
import 'package:store_app_clean_architecture/features/user_feature/domain/repository/register_user_repository_impl.dart';
import 'package:store_app_clean_architecture/features/user_feature/domain/use_case/login_user_use_case.dart';
import 'package:store_app_clean_architecture/features/user_feature/domain/use_case/register_user_use_case.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/profile/profile_bloc.dart';
import 'package:store_app_clean_architecture/features/user_feature/presentation/bloc/resgiter/register_bloc.dart';

var serviceLocator = GetIt.instance;
Future<void> initGeiIt() async {
  //util
  serviceLocator.registerSingleton<PaymentHandler>(
    ZarinpalPaymentHandler(),
  );
  serviceLocator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );
  serviceLocator.registerSingleton<ThemeBloc>(
    ThemeBloc(),
  );
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
      serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<CategoryDataSource>(
    CategoryDataSource(
      serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<ProductsDataSource>(
    ProductsDataSource(
      serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<GalleryProductDataSource>(
    GalleryProductDataSource(
      serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<DetailProductDatasource>(
    DetailProductDatasource(
      serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<BasketDataSource>(
    BasketDataSource(
      serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<CommentsDataSource>(
    CommentsDataSource(
      serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<RegisterUserDataSource>(
    RegisterUserDataSource(
      serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<LoginUserDataSource>(
    LoginUserDataSource(
      serviceLocator.get(),
    ),
  );
  //repositories
  serviceLocator.registerSingleton<BannersRepositoryImpl>(
    BannersRepositoryImpl(
      serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<CategoriesRepositoryImpl>(
    CategoriesRepositoryImpl(
      serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<ProductsRepositoryImpl>(
    ProductsRepositoryImpl(
      serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<GalleryProductRepositoryImpl>(
    GalleryProductRepositoryImpl(
      serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<DetailProductRepositoryImpl>(
    DetailProductRepositoryImpl(
      serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<BasketRepositoryImpl>(
    BasketRepositoryImpl(
      serviceLocator.get(),
    ),
  );

  serviceLocator.registerSingleton<CommentsRepository>(
    CommentsRepositoryImpl(
      dataSource: serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<RegisterUserRepository>(
    RegisterUserRepositoryImpl(
      dataSource: serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<LoginUserRepository>(
    LoginUserRepositoryImpl(
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
  serviceLocator.registerSingleton<CommentsUseCase>(
    CommentsUseCase(
      repository: serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<RegisterUserUseCase>(
    RegisterUserUseCase(
      repository: serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<LoginUserUseCase>(
    LoginUserUseCase(
      serviceLocator.get(),
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
      ordersBox: serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<BasketBloc>(
    BasketBloc(
      basketUsecase: serviceLocator.get(),
      zarinpalPaymentHandler: serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<CommentsBloc>(
    CommentsBloc(
      useCase: serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<RegisterBloc>(
    RegisterBloc(
      useCase: serviceLocator.get(),
    ),
  );
  serviceLocator.registerSingleton<ProfileBloc>(
    ProfileBloc(
      serviceLocator.get(),
    ),
  );
}
