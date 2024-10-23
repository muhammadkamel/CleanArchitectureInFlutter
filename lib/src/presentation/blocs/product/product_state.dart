part of 'product_bloc.dart';

enum ProductStatus {
  initial,
  loading,
  success,
  failure,
}

final class ProductState extends Equatable {
  const ProductState({
    required this.status,
    this.product,
    this.products,
    this.message,
  });
  final ProductStatus status;
  final ProductEntity? product;
  final List<ProductEntity>? products;
  final String? message;

  ProductState copyWith({
    ProductStatus? status,
    ProductEntity? product,
    List<ProductEntity>? products,
    String? message,
  }) {
    return ProductState(
      status: status ?? this.status,
      product: product ?? this.product,
      products: products ?? this.products,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        status,
        product,
        products,
        message,
      ];
}

extension ProductStateX on ProductState {
  maybeMap<T>({
    T Function(ProductState)? initial,
    T Function(ProductState)? loading,
    T Function(ProductState)? success,
    T Function(ProductState)? failure,
    required T Function(ProductState) orElse,
  }) {
    return switch (status) {
      ProductStatus.initial => initial != null ? initial(this) : orElse(this),
      ProductStatus.loading => loading != null ? loading(this) : orElse(this),
      ProductStatus.success => success != null ? success(this) : orElse(this),
      ProductStatus.failure => failure != null ? failure(this) : orElse(this),
    };
  }
}
