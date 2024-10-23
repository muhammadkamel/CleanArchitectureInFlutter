import 'package:oth_app/src/application/contracts/products.dart';
import 'package:oth_app/src/core/generic_types/future_either_failure.dart';
import 'package:oth_app/src/domain/domain.dart';

class GetProductsUseCaseImpl implements GetProductsUseCase {
  final ProductRepository _productRepository;

  GetProductsUseCaseImpl({required ProductRepository productRepository})
      : _productRepository = productRepository;

  @override
  FutureEitherFailureOrType<List<ProductEntity>> call(void params) {
    return _productRepository.getProducts();
  }
}
