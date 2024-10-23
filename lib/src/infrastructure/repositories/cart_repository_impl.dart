import 'package:oth_app/src/core/generic_types/future_either_failure.dart';
import 'package:oth_app/src/domain/domain.dart';
import 'package:oth_app/src/infrastructure/infrastructure.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource _cartDataSource;

  CartRepositoryImpl({required CartRemoteDataSource cartDataSource})
      : _cartDataSource = cartDataSource;

  @override
  FutureEitherFailureOrType<CartEntity> addProduct(CartItemEntity product) {
    return _cartDataSource.addProduct(product);
  }

  @override
  FutureEitherFailureOrType<CartEntity> getCartById(String id) {
    return _cartDataSource.getCartById(id);
  }

  @override
  FutureEitherFailureOrType<CartEntity> removeProduct(CartItemEntity product) {
    return _cartDataSource.removeProduct(product);
  }

  @override
  FutureEitherFailureOrType<CartEntity> updateProductQuantity(
      CartItemEntity product) {
    return _cartDataSource.updateProductQuantity(product);
  }
}
