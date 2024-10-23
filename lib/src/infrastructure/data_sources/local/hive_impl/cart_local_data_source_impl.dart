import 'package:oth_app/src/core/generic_types/future_either_failure.dart';
import 'package:oth_app/src/domain/entities/cart_entity.dart';
import 'package:oth_app/src/domain/entities/cart_item_entity.dart';
import 'package:oth_app/src/infrastructure/infrastructure.dart';

class CartLocalDataSourceImpl implements CartRemoteDataSource {
  @override
  FutureEitherFailureOrType<CartEntity> addProduct(CartItemEntity product) {
    // TODO: implement addProduct
    throw UnimplementedError();
  }

  @override
  FutureEitherFailureOrType<CartEntity> getCartById(String id) {
    // TODO: implement getCartById
    throw UnimplementedError();
  }

  @override
  FutureEitherFailureOrType<CartEntity> removeProduct(CartItemEntity product) {
    // TODO: implement removeProduct
    throw UnimplementedError();
  }

  @override
  FutureEitherFailureOrType<CartEntity> updateProductQuantity(
      CartItemEntity product) {
    // TODO: implement updateProductQuantity
    throw UnimplementedError();
  }
}
