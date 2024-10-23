import 'package:oth_app/src/application/application.dart';
import 'package:oth_app/src/core/generic_types/future_either_failure.dart';
import 'package:oth_app/src/domain/repositories/repositories.dart';
import 'package:oth_app/src/infrastructure/infrastructure.dart';

class SaveProductsLocalUseCaseImpl implements SaveProductsLocalUseCase {
  final ProductRepository _productRepository;

  const SaveProductsLocalUseCaseImpl(
      {required ProductRepository productRepository})
      : _productRepository = productRepository;
  @override
  FutureEitherFailureOrType<bool> call(List<ProductModel> params) {
    return _productRepository.saveProducts(params);
  }
}
