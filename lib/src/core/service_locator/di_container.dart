import 'package:hive/hive.dart';
import 'package:oth_app/di_container.dart';
import 'package:oth_app/src/infrastructure/infrastructure.dart';

void registerDataSources({
  required Box<ProductModel> productBox,
}) async {
  getIt.registerSingleton<CartRemoteDataSource>(
    CartRemoteDataSourceImpl(
      apiConsumer: getIt(),
    ),
  );
  getIt.registerSingleton<ProductLocalDataSource>(
    ProductLocalDataSourceImpl(
      productBox: productBox,
    ),
  );
  getIt.registerSingleton<ProductRemoteDataSource>(
    ProductRemoteDataSourceImpl(
      apiConsumer: getIt(),
    ),
  );
}
