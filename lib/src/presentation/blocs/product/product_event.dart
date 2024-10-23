part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

final class GetProductsEvent extends ProductEvent {
  const GetProductsEvent();
}

final class RefreshProductsEvent extends ProductEvent {
  const RefreshProductsEvent();
}

final class GetProductByIdEvent extends ProductEvent {
  const GetProductByIdEvent({required this.productId});
  final int productId;

  @override
  List<Object> get props => [productId];
}
