import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/domain/entities/product_entity.dart';
import 'package:oth_app/src/infrastructure/infrastructure.dart';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final Box<ProductModel> _productBox;

  ProductLocalDataSourceImpl({
    required Box<ProductModel> productBox,
  }) : _productBox = productBox;

  @override
  FutureEitherFailureOrType<List<ProductEntity>> getProducts() async {
    try {
      final products = _productBox.values.toList();
      return Right(
          products.map((ProductModel product) => product.toEntity()).toList());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  FutureEitherFailureOrType<bool> saveProducts(
      List<ProductModel> products) async {
    for (final product in products) {
      await _productBox.put(product.id, product);
    }
    return const Right(true);
  }
}
