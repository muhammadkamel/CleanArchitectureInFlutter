import 'package:oth_app/di_container.dart';
import 'package:oth_app/src/domain/repositories/repositories.dart';
import 'package:oth_app/src/infrastructure/infrastructure.dart';

void registerRepositories() {
  getIt.registerSingleton<CartRepository>(
    CartRepositoryImpl(cartDataSource: getIt()),
  );
  getIt.registerSingleton<ProductRepository>(
    ProductRepositoryImpl(
      productRemoteDataSource: getIt(),
      productLocalDataSource: getIt(),
      internetChecker: getIt(),
    ),
  );
}
