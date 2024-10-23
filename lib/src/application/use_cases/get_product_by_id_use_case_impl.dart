import 'package:oth_app/src/application/contracts/products.dart';
import 'package:oth_app/src/core/generic_types/future_either_failure.dart';
import 'package:oth_app/src/domain/entities/product_entity.dart';
import 'package:oth_app/src/domain/repositories/repositories.dart';

class GetProductByIdUseCaseImpl implements GetProductByIdUseCase {
  final ProductRepository _productRepository;

  const GetProductByIdUseCaseImpl({
    required ProductRepository productRepository,
  }) : _productRepository = productRepository;

  @override
  FutureEitherFailureOrType<ProductEntity> call(productId) {
    return _productRepository.getProductById(productId);
  }
}
