import 'package:oth_app/src/application/contracts/cart.dart';
import 'package:oth_app/src/core/generic_types/future_either_failure.dart';
import 'package:oth_app/src/domain/domain.dart';

class UpdateCartProductUseCaseImpl implements UpdateCartProductUseCase {
  final CartRepository _cartRepository;

  UpdateCartProductUseCaseImpl({required CartRepository cartRepository})
      : _cartRepository = cartRepository;
  @override
  FutureEitherFailureOrType<CartEntity> call(CartItemEntity params) {
    return _cartRepository.updateProductQuantity(params);
  }
}
