import 'package:dartz/dartz.dart';
import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/domain/entities/cart_entity.dart';
import 'package:oth_app/src/domain/entities/cart_item_entity.dart';
import 'package:oth_app/src/infrastructure/infrastructure.dart';

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final BaseApiConsumer _apiConsumer;

  CartRemoteDataSourceImpl({
    required BaseApiConsumer apiConsumer,
  }) : _apiConsumer = apiConsumer;

  @override
  FutureEitherFailureOrType<CartEntity> addProduct(
      CartItemEntity product) async {
    try {
      final response = await _apiConsumer.post(
        Endpoints.carts,
        data: {
          "userId": 3,
          "date": DateTime.now().toString(),
          "products": [
            {
              "productId": product.productId,
              "quantity": product.quantity,
            }
          ]
        },
      );

      if (response.statusCode != 200) {
        return Left(
          ServerFailure('Failed to add product to cart'),
        );
      }
      return Right(CartModel.fromJson(response.data).toEntity());
    } catch (e) {
      return Left(
        ServerFailure(e.toString()),
      );
    }
  }

  @override
  FutureEitherFailureOrType<CartEntity> getCartById(String id) async {
    try {
      final response = await _apiConsumer.get(
        "${Endpoints.carts}/$id",
      );

      if (response.statusCode != 200) {
        return Left(
          ServerFailure('Failed to get cart by id'),
        );
      }
      return Right(CartModel.fromJson(response.data).toEntity());
    } catch (e) {
      return Left(
        ServerFailure(e.toString()),
      );
    }
  }

  @override
  FutureEitherFailureOrType<CartEntity> removeProduct(
      CartItemEntity product) async {
    try {
      final response = await _apiConsumer.post(
        Endpoints.carts,
        data: {
          "userId": 3,
          "date": "2024-02-05",
          "products": [
            {"productId": 5, "quantity": 3}
          ]
        },
      );

      if (response.statusCode != 200) {
        return Left(
          ServerFailure('Failed to add product to cart'),
        );
      }
      return Right(CartModel.fromJson(response.data).toEntity());
    } catch (e) {
      return Left(
        ServerFailure(e.toString()),
      );
    }
  }

  @override
  FutureEitherFailureOrType<CartEntity> updateProductQuantity(
      CartItemEntity product) async {
    try {
      final response = await _apiConsumer.post(
        Endpoints.carts,
        data: {
          "userId": 3,
          "date": "2024-02-05",
          "products": [
            {"productId": 5, "quantity": 3}
          ]
        },
      );

      if (response.statusCode != 200) {
        return Left(
          ServerFailure('Failed to add product to cart'),
        );
      }
      return Right(CartModel.fromJson(response.data).toEntity());
    } catch (e) {
      return Left(
        ServerFailure(e.toString()),
      );
    }
  }
}
