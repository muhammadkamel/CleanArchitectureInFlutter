import 'package:dartz/dartz.dart';
import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/domain/entities/product_entity.dart';
import 'package:oth_app/src/infrastructure/infrastructure.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final BaseApiConsumer _apiConsumer;

  ProductRemoteDataSourceImpl({
    required BaseApiConsumer apiConsumer,
  }) : _apiConsumer = apiConsumer;

  @override
  FutureEitherFailureOrType<List<ProductEntity>> getProducts() async {
    try {
      final response = await _apiConsumer.get(Endpoints.products);
      final data = response.data as List<dynamic>;

      if (response.statusCode != 200) {
        return Left(
          ServerFailure('Failed to add product to cart'),
        );
      }

      final products = data.map<ProductEntity>(
        (product) {
          return ProductModel.fromJson(product).toEntity();
        },
      ).toList();
      return Right(products);
    } catch (e) {
      return Left(
        ServerFailure(e.toString()),
      );
    }
  }

  @override
  FutureEitherFailureOrType<ProductEntity> getProductById(int productId) async {
    try {
      final response = await _apiConsumer.get(
        Endpoints.productsById.replaceFirst(
          '{productId}',
          productId.toString(),
        ),
      );
      final data = response.data;

      if (response.statusCode != 200) {
        return Left(
          ServerFailure('Failed to add product to cart'),
        );
      }

      final product = ProductModel.fromJson(data).toEntity();

      return Right(product);
    } catch (e) {
      return Left(
        ServerFailure(e.toString()),
      );
    }
  }
}
