import 'package:oth_app/src/application/contracts/cart.dart';
import 'package:oth_app/src/core/generic_types/future_either_failure.dart';
import 'package:oth_app/src/domain/domain.dart';

class AddCartProductUseCaseImpl implements AddCartProductUseCase {
  final CartRepository _cartRepository;

  AddCartProductUseCaseImpl({required CartRepository cartRepository})
      : _cartRepository = cartRepository;

  @override
  FutureEitherFailureOrType<CartEntity> call(CartItemEntity product) {
    return _cartRepository.addProduct(product);
  }
}
