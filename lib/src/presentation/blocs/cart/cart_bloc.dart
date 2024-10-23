import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oth_app/src/application/application.dart';
import 'package:oth_app/src/domain/domain.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartByIdUseCase _getCartByIdUseCase;
  final AddCartProductUseCase _addCartProductUseCase;
  final RemoveCartProductUseCase _removeCartProductUseCase;

  CartBloc({
    required GetCartByIdUseCase getCartByIdUseCase,
    required AddCartProductUseCase addCartProductUseCase,
    required RemoveCartProductUseCase removeCartProductUseCase,
  })  : _getCartByIdUseCase = getCartByIdUseCase,
        _addCartProductUseCase = addCartProductUseCase,
        _removeCartProductUseCase = removeCartProductUseCase,
        super(CartState(
          status: CartStatus.initial,
        )) {
    on<AddToCartEvent>(_addToCartHandler);
    on<GetCartByIdEvent>(_getCartByIdHandler);
    on<RemoveFromCartEvent>(_removeFromCartHandler);
  }

  FutureOr<void> _addToCartHandler(
      AddToCartEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.loading));
    final result = await _addCartProductUseCase.call(event.product);
    final CartEntity? cart =
        await result.fold((l) async => null, (r) async => r);

    emit(
      state.copyWith(
        status: CartStatus.success,
        cart: cart?.copyWith(
          total: event.product.price,
        ),
      ),
    );
  }

  FutureOr<void> _getCartByIdHandler(
      GetCartByIdEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.loading));
    final result = await _getCartByIdUseCase.call(event.id);

    final CartEntity? cart =
        await result.fold((l) async => null, (r) async => r);
    emit(
      state.copyWith(
        status: CartStatus.success,
        cart: cart,
      ),
    );
  }

  FutureOr<void> _removeFromCartHandler(
      RemoveFromCartEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.loading));
    final result = await _removeCartProductUseCase.call(event.product);
    final CartEntity? cart =
        await result.fold((l) async => null, (r) async => r);
    emit(
      state.copyWith(
        status: CartStatus.success,
        cart: cart,
      ),
    );
  }
}
