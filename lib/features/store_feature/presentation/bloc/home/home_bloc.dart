import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/banner_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/category_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/product_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/banners_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/categories_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/products_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/home/home_event.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/home/home_state.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/home/home_status.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BannersUseCase bannersUsecase;
  final CategoriesUsecase categoriesUsecase;
  final ProductsUsecase productsUsecase;
  HomeBloc({
    required this.bannersUsecase,
    required this.categoriesUsecase,
    required this.productsUsecase,
  }) : super(
          HomeState(
            status: HomeInitStatus(),
          ),
        ) {
    on<HomeSendRequestEvent>(
      (event, emit) async {
        emit(
          state.setStatus(
            HomeLoadingStatus(),
          ),
        );
        final Either<CustomError, List<BannerEntity>> bannersResponse =
            await bannersUsecase();
        final Either<CustomError, List<CategoryEntity>> categoriesResponse =
            await categoriesUsecase.callAllCategories();

        final Either<CustomError, List<ProductEntity>> hotestProductsResponse =
            await productsUsecase(filter: 'Hotest');

        final Either<CustomError, List<ProductEntity>>
            bestSellerProductsResponse =
            await productsUsecase(filter: 'Best Seller');

        if (bannersResponse.isRight() &&
            categoriesResponse.isRight() &&
            hotestProductsResponse.isRight() &&
            bestSellerProductsResponse.isRight()) {
          List<BannerEntity> bannersList = [];
          List<CategoryEntity> categoriesList = [];
          List<ProductEntity> hotestProductsList = [];
          List<ProductEntity> bestSellerProductsList = [];
          bannersResponse.fold(
            (l) => null,
            (banners) => bannersList = banners,
          );
          categoriesResponse.fold(
            (l) => null,
            (categories) => categoriesList = categories,
          );
          hotestProductsResponse.fold(
            (l) => null,
            (products) => hotestProductsList = products,
          );
          bestSellerProductsResponse.fold(
            (l) => null,
            (products) => bestSellerProductsList = products,
          );
          emit(
            state.setStatus(
              HomeSuccessStatus(
                banners: bannersList,
                categories: categoriesList,
                hotestProducts: hotestProductsList,
                bestSellerProducts: bestSellerProductsList,
              ),
            ),
          );
        } else {
          emit(
            state.setStatus(
              HomeFailedStatus(
                error: CustomError(
                  header: 'خطا در برقراری ارتباط با سرور',
                  description:
                      'اتصال اینترنت خود را بررسی نمایید و دوباره تلاش کنید.همچنین فیلتر شکن خود را خاموش نمایید',
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
