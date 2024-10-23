import 'package:oth_app/di_container.dart';
import 'package:oth_app/src/application/contracts/cart.dart';
import 'package:oth_app/src/application/contracts/products.dart';
import 'package:oth_app/src/application/use_cases/use_cases.dart';

void registerUseCases() {
  getIt.registerSingleton<GetCartByIdUseCase>(
    GetCartByIdUseCaseImpl(
      cartRepository: getIt(),
    ),
  );
  getIt.registerSingleton<AddCartProductUseCase>(
    AddCartProductUseCaseImpl(
      cartRepository: getIt(),
    ),
  );
  getIt.registerSingleton<GetProductsUseCase>(
    GetProductsUseCaseImpl(
      productRepository: getIt(),
    ),
  );
  getIt.registerSingleton<GetProductByIdUseCase>(
    GetProductByIdUseCaseImpl(
      productRepository: getIt(),
    ),
  );
  getIt.registerSingleton<UpdateCartProductUseCase>(
    UpdateCartProductUseCaseImpl(
      cartRepository: getIt(),
    ),
  );
  getIt.registerSingleton<RemoveCartProductUseCase>(
    RemoveCartProductUseCaseImpl(
      cartRepository: getIt(),
    ),
  );
  getIt.registerSingleton<SaveProductsLocalUseCase>(
    SaveProductsLocalUseCaseImpl(
      productRepository: getIt(),
    ),
  );
}
