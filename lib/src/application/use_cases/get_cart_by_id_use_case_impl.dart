import 'package:oth_app/src/application/contracts/cart.dart';
import 'package:oth_app/src/core/generic_types/future_either_failure.dart';
import 'package:oth_app/src/domain/domain.dart';

class GetCartByIdUseCaseImpl implements GetCartByIdUseCase {
  final CartRepository _cartRepository;

  GetCartByIdUseCaseImpl({required CartRepository cartRepository})
      : _cartRepository = cartRepository;

  @override
  FutureEitherFailureOrType<CartEntity> call(String id) {
    return _cartRepository.getCartById(id);
  }
}
