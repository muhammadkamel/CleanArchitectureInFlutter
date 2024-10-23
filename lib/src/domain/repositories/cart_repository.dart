import 'package:oth_app/src/core/generic_types/future_either_failure.dart';
import 'package:oth_app/src/domain/domain.dart';

abstract class CartRepository {
  FutureEitherFailureOrType<CartEntity> addProduct(CartItemEntity product);
  FutureEitherFailureOrType<CartEntity> getCartById(String id);
  FutureEitherFailureOrType<CartEntity> removeProduct(CartItemEntity product);
  FutureEitherFailureOrType<CartEntity> updateProductQuantity(
      CartItemEntity product);
}
