import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/banner_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/banners_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/home/home_event.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/home/home_state.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/home/home_status.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BannersUseCase bannersUsecase;
  HomeBloc({required this.bannersUsecase})
      : super(
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

        if (bannersResponse.isRight()) {
          bannersResponse.fold(
            (l) => null,
            (banners) => emit(
              state.setStatus(
                HomeSuccessStatus(banners: banners),
              ),
            ),
          );
        } else {
          emit(
            state.setStatus(
              HomeFailedStatus(
                error: CustomError(
                  header: 'D',
                  description: 'DD',
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
