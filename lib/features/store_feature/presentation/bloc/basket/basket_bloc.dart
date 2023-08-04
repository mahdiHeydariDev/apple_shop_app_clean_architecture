import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/order_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/basket_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/basket/basket_event.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/basket/basket_state.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/basket/basket_status.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final BasketUsecase basketUsecase;

  BasketBloc({
    required this.basketUsecase,
  }) : super(
          BasketState(
            status: BasketLoadingStatus(),
          ),
        ) {
    on<BasketSendRequestEvent>(
      (event, emit) async {
        emit(
          state.setStatus(
            BasketLoadingStatus(),
          ),
        );
        final Either<CustomError, List<OrderEntity>> ordersResponse =
            await basketUsecase.callGetorders();
        if (ordersResponse.isRight()) {
          List<OrderEntity>? ordersList;

          ordersResponse.fold(
              (l) => null, (ordersSuccess) => ordersList = ordersSuccess);
          int payablePrice = ordersList!.fold(
            0,
            (previousValue, element) =>
                previousValue + (element.finalPrice * element.count),
          );
          emit(
            state.setStatus(
              BasketSuccessStatus(
                orders: ordersList!,
                payablePrice: payablePrice,
              ),
            ),
          );
        }
      },
    );
    on<BasketIncreseOrderCount>((event, emit) async {
      await basketUsecase.increaseOrderCount(selectedOrder: event.order);
      emit(
        state.setStatus(
          BasketLoadingStatus(),
        ),
      );
      final Either<CustomError, List<OrderEntity>> ordersResponse =
          await basketUsecase.callGetorders();
      if (ordersResponse.isRight()) {
        List<OrderEntity>? ordersList;

        ordersResponse.fold(
            (l) => null, (ordersSuccess) => ordersList = ordersSuccess);
        int payablePrice = ordersList!.fold(
          0,
          (previousValue, element) =>
              previousValue + (element.finalPrice * element.count),
        );
        emit(
          state.setStatus(
            BasketSuccessStatus(
              orders: ordersList!,
              payablePrice: payablePrice,
            ),
          ),
        );
      }
    });
  }
}
