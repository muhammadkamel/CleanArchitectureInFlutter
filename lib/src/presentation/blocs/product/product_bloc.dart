import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oth_app/src/application/contracts/products.dart';
import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/domain/entities/product_entity.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase _productUseCase;
  final GetProductByIdUseCase _productByIdUseCase;
  final SaveProductsLocalUseCase _saveProductsLocalUseCase;

  ProductBloc({
    required GetProductsUseCase productUseCase,
    required GetProductByIdUseCase productByIdUseCase,
    required SaveProductsLocalUseCase saveProductsLocalUseCase,
  })  : _productUseCase = productUseCase,
        _productByIdUseCase = productByIdUseCase,
        _saveProductsLocalUseCase = saveProductsLocalUseCase,
        super(ProductState(
          status: ProductStatus.initial,
        )) {
    on<GetProductsEvent>(_getProductsHandler);
    on<RefreshProductsEvent>(_refreshProductsHandler);
    on<GetProductByIdEvent>(_getProductByIdHandler);
  }

  FutureOr<void> _getProductsHandler(
      GetProductsEvent event, Emitter<ProductState> emit) async {
    try {
      emit(state.copyWith(status: ProductStatus.loading));
      final result = await _productUseCase.call(null);

      await result.fold(
        (l) async {
          emit(
            state.copyWith(
              status: ProductStatus.failure,
              message: l.toString(),
            ),
          );
        },
        (products) async {
          await _saveProductsLocalUseCase
              .call(products.map((e) => e.toModel()).toList());
          emit(
            state.copyWith(
              status: ProductStatus.success,
              products: products,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProductStatus.failure,
          message: e.toString(),
        ),
      );
    }
  }

  FutureOr<void> _refreshProductsHandler(
      RefreshProductsEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductStatus.loading));
    final result = await _productUseCase.call(null);

    await result.fold(
      (l) async {
        emit(state.copyWith(status: ProductStatus.failure, message: l.message));
      },
      (r) async {
        emit(
          state.copyWith(
            status: ProductStatus.success,
            products: r,
          ),
        );
      },
    );
  }

  FutureOr<void> _getProductByIdHandler(
      GetProductByIdEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductStatus.loading));
    final result = await _productByIdUseCase.call(event.productId);

    await result.fold(
      (l) async {
        emit(state.copyWith(status: ProductStatus.failure, message: l.message));
      },
      (r) async {
        emit(
          state.copyWith(
            status: ProductStatus.success,
            product: r,
          ),
        );
      },
    );
  }
}
