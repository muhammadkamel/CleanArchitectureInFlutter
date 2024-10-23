import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/domain/domain.dart';

abstract class GetCartByIdUseCase extends AsyncCallable<CartEntity, String> {}

abstract class AddCartProductUseCase
    extends AsyncCallable<CartEntity, CartItemEntity> {}

abstract class RemoveCartProductUseCase
    extends AsyncCallable<CartEntity, CartItemEntity> {}

abstract class UpdateCartProductUseCase
    extends AsyncCallable<CartEntity, CartItemEntity> {}
