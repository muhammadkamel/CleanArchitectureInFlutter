import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/domain/domain.dart';
import 'package:oth_app/src/infrastructure/infrastructure.dart';

abstract class GetProductsUseCase
    extends AsyncCallable<List<ProductEntity>, void> {}

abstract class GetProductByIdUseCase
    extends AsyncCallable<ProductEntity, int> {}

abstract class SaveProductsLocalUseCase
    extends AsyncCallable<bool, List<ProductModel>> {}
