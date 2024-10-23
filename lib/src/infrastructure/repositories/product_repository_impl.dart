import 'package:oth_app/src/core/generic_types/future_either_failure.dart';
import 'package:oth_app/src/core/internet_checker.dart';
import 'package:oth_app/src/domain/entities/product_entity.dart';
import 'package:oth_app/src/domain/repositories/repositories.dart';
import 'package:oth_app/src/infrastructure/infrastructure.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _productRemoteDataSource;
  final ProductLocalDataSource _productLocalDataSource;
  final InternetChecker _internetChecker;

  ProductRepositoryImpl({
    required ProductRemoteDataSource productRemoteDataSource,
    required ProductLocalDataSource productLocalDataSource,
    required InternetChecker internetChecker,
  })  : _productRemoteDataSource = productRemoteDataSource,
        _productLocalDataSource = productLocalDataSource,
        _internetChecker = internetChecker;

  @override
  FutureEitherFailureOrType<List<ProductEntity>> getProducts() async {
    final isConnected = await _internetChecker.isConnected;
    if (isConnected) {
      return _productRemoteDataSource.getProducts();
    } else {
      return _productLocalDataSource.getProducts();
    }
  }

  @override
  FutureEitherFailureOrType<ProductEntity> getProductById(int productId) async {
    return _productRemoteDataSource.getProductById(productId);
  }

  @override
  FutureEitherFailureOrType<bool> saveProducts(List<ProductModel> products) {
    return _productLocalDataSource.saveProducts(products);
  }
}
