part of 'cart_bloc.dart';

enum CartStatus {
  initial,
  loading,
  success,
  failure;
}

final class CartState extends Equatable {
  const CartState({
    required this.status,
    this.cart,
  });
  final CartStatus status;
  final CartEntity? cart;

  CartState copyWith({
    CartStatus? status,
    CartEntity? cart,
  }) {
    return CartState(
      status: status ?? this.status,
      cart: cart ?? this.cart,
    );
  }

  @override
  List<Object?> get props => [
        status,
        cart,
      ];
}

extension CartStateX on CartState {
  maybeMap<T>({
    T Function(CartState)? initial,
    T Function(CartState)? loading,
    T Function(CartState)? success,
    T Function(CartState)? failure,
    required T Function(CartState) orElse,
  }) {
    return switch (status) {
      CartStatus.initial => initial != null ? initial(this) : orElse(this),
      CartStatus.loading => loading != null ? loading(this) : orElse(this),
      CartStatus.success => success != null ? success(this) : orElse(this),
      CartStatus.failure => failure != null ? failure(this) : orElse(this),
    };
  }
}
