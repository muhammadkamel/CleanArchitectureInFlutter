import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/infrastructure/infrastructure.dart';

final GetIt getIt = GetIt.instance;

Future<void> diContainer() async {
  final productBox = await Hive.openBox<ProductModel>('products');

  registerExternal();
  registerDataSources(
    productBox: productBox,
  );
  registerRepositories();
  registerUseCases();
}
