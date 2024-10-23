import 'package:oth_app/src/core/generic_types/future_either_failure.dart';
import 'package:oth_app/src/domain/entities/product_entity.dart';
import 'package:oth_app/src/infrastructure/infrastructure.dart';

abstract class ProductRepository {
  FutureEitherFailureOrType<List<ProductEntity>> getProducts();
  FutureEitherFailureOrType<ProductEntity> getProductById(int productId);
  FutureEitherFailureOrType<bool> saveProducts(List<ProductModel> products);
}
