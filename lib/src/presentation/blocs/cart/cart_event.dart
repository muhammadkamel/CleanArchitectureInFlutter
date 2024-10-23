part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

final class GetCartByIdEvent extends CartEvent {
  final String id;
  const GetCartByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}

final class AddToCartEvent extends CartEvent {
  final CartItemEntity product;
  const AddToCartEvent(this.product);

  @override
  List<Object> get props => [product];
}

final class RemoveFromCartEvent extends CartEvent {
  final CartItemEntity product;
  const RemoveFromCartEvent(this.product);

  @override
  List<Object> get props => [product];
}
