import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app_clean_architecture/core/utils/errors/custom_error.dart';
import 'package:store_app_clean_architecture/core/utils/payment_handler.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/order_entity.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/use_cases/basket_use_case.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/basket/basket_event.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/basket/basket_state.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/basket/basket_status.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final BasketUsecase _basketUsecase;
  final PaymentHandler _zarinpalPaymentHandler;

  BasketBloc({
    required BasketUsecase basketUsecase,
    required PaymentHandler zarinpalPaymentHandler,
  })  : _zarinpalPaymentHandler = zarinpalPaymentHandler,
        _basketUsecase = basketUsecase,
        super(
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
            await _basketUsecase.callGetorders();
        if (ordersResponse.isRight()) {
          List<OrderEntity>? ordersList;

          ordersResponse.fold(
              (l) => null, (ordersSuccess) => ordersList = ordersSuccess);
          int payablePrice = ordersList!.fold(
            0,
            (previousValue, element) =>
                previousValue + (element.finalPrice * element.count),
          );
          if (ordersList!.isEmpty) {
            emit(
              state.setStatus(
                BasketEmptyStatus(),
              ),
            );
          } else {
            emit(
              state.setStatus(
                BasketSuccessStatus(
                  orders: ordersList!,
                  payablePrice: payablePrice,
                ),
              ),
            );
          }
        }
      },
    );
    on<BasketIncreseOrderCount>((event, emit) async {
      await _basketUsecase.increaseOrderCount(selectedOrder: event.order);
      emit(
        state.setStatus(
          BasketLoadingStatus(),
        ),
      );
      final Either<CustomError, List<OrderEntity>> ordersResponse =
          await _basketUsecase.callGetorders();
      if (ordersResponse.isRight()) {
        List<OrderEntity>? ordersList;

        ordersResponse.fold(
            (l) => null, (ordersSuccess) => ordersList = ordersSuccess);
        int payablePrice = ordersList!.fold(
          0,
          (previousValue, element) =>
              previousValue + (element.finalPrice * element.count),
        );
        if (ordersList!.isEmpty) {
          emit(
            state.setStatus(
              BasketEmptyStatus(),
            ),
          );
        } else {
          emit(
            state.setStatus(
              BasketSuccessStatus(
                orders: ordersList!,
                payablePrice: payablePrice,
              ),
            ),
          );
        }
      }
    });
    on<BasketDecreseOrderCount>((event, emit) async {
      await _basketUsecase.decreaseOrderCount(selectedOrder: event.order);
      emit(
        state.setStatus(
          BasketLoadingStatus(),
        ),
      );
      final Either<CustomError, List<OrderEntity>> ordersResponse =
          await _basketUsecase.callGetorders();
      if (ordersResponse.isRight()) {
        List<OrderEntity>? ordersList;

        ordersResponse.fold(
            (l) => null, (ordersSuccess) => ordersList = ordersSuccess);
        int payablePrice = ordersList!.fold(
          0,
          (previousValue, element) =>
              previousValue + (element.finalPrice * element.count),
        );
        if (ordersList!.isEmpty) {
          emit(
            state.setStatus(
              BasketEmptyStatus(),
            ),
          );
        } else {
          emit(
            state.setStatus(
              BasketSuccessStatus(
                orders: ordersList!,
                payablePrice: payablePrice,
              ),
            ),
          );
        }
      }
    });
    on<BasketDeleteOrder>((event, emit) async {
      await _basketUsecase.deleteOrder(selectedOrder: event.order);
      emit(
        state.setStatus(
          BasketLoadingStatus(),
        ),
      );
      final Either<CustomError, List<OrderEntity>> ordersResponse =
          await _basketUsecase.callGetorders();
      if (ordersResponse.isRight()) {
        List<OrderEntity>? ordersList;

        ordersResponse.fold(
            (l) => null, (ordersSuccess) => ordersList = ordersSuccess);
        int payablePrice = ordersList!.fold(
          0,
          (previousValue, element) =>
              previousValue + (element.finalPrice * element.count),
        );
        if (ordersList!.isEmpty) {
          emit(
            state.setStatus(
              BasketEmptyStatus(),
            ),
          );
        } else {
          emit(
            state.setStatus(
              BasketSuccessStatus(
                orders: ordersList!,
                payablePrice: payablePrice,
              ),
            ),
          );
        }
      }
    });
    on<BasketPaymentRequestEvent>((event, emit) {
      _zarinpalPaymentHandler.initRequestPayment(amount: event.amount);
      _zarinpalPaymentHandler.sendRequestPayment();
    });
  }
}
