import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/domain/entities/cart_entity.dart';
import 'package:oth_app/src/domain/entities/cart_item_entity.dart';
import 'package:oth_app/src/infrastructure/infrastructure.dart';

class MockApiConsumer extends Mock implements BaseApiConsumer {}

void main() {
  late CartRemoteDataSourceImpl cartRemoteDataSource;
  late MockApiConsumer mockApiConsumer;

  setUp(() {
    mockApiConsumer = MockApiConsumer();
    cartRemoteDataSource =
        CartRemoteDataSourceImpl(apiConsumer: mockApiConsumer);
  });

  group('CartRemoteDataSourceImpl', () {
    final testCartItem = CartItemEntity(productId: 5, quantity: 3);
    final testCart = CartModel(
      id: 2,
      userId: 323,
      date: '2022-01-01',
      products: [
        ProductItemModel(
          productId: 5,
          quantity: 3,
        ),
        ProductItemModel(
          productId: 6,
          quantity: 31,
        ),
      ],
    );

    test('should add product successfully', () async {
      // Arrange
      when(() => mockApiConsumer.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                data: testCart.toJson(),
                statusCode: 200,
                requestOptions: RequestOptions(),
              ));

      // Act
      final result = await cartRemoteDataSource.addProduct(testCartItem);

      // Assert
      expect(result, isA<Right<Failure, CartEntity>>());
      expect((result as Right).value, isA<CartEntity>());
    });

    test('should return error when adding product fails', () async {
      // Arrange
      when(() => mockApiConsumer.post(any(), data: any(named: 'data')))
          .thenAnswer(
        (_) async => Response(
          statusCode: 400,
          requestOptions: RequestOptions(),
        ),
      );

      // Act
      final result = await cartRemoteDataSource.addProduct(testCartItem);

      // Assert
      expect(result, isA<Left<Failure, CartEntity>>());
      expect((result as Left).value, isA<ServerFailure>());
    });

    test('should get cart by ID successfully', () async {
      // Arrange
      when(() => mockApiConsumer.get(any())).thenAnswer(
        (_) async => Response(
          data: testCart.toJson(),
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      // Act
      final result = await cartRemoteDataSource.getCartById('1');

      // Assert
      expect(result, isA<Right<Failure, CartEntity>>());
      expect((result as Right).value, isA<CartEntity>());
    });

    test('should return error when getting cart by ID fails', () async {
      // Arrange
      when(() => mockApiConsumer.get(any())).thenAnswer((_) async => Response(
            statusCode: 404,
            requestOptions: RequestOptions(),
          ));

      // Act
      final result = await cartRemoteDataSource.getCartById('1');

      // Assert
      expect(result, isA<Left<Failure, CartEntity>>());
      expect((result as Left).value, isA<ServerFailure>());
    });

    test('should remove product successfully', () async {
      // Arrange
      when(() => mockApiConsumer.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                data: testCart.toJson(),
                statusCode: 200,
                requestOptions: RequestOptions(),
              ));

      // Act
      final result = await cartRemoteDataSource.removeProduct(testCartItem);

      // Assert
      expect(result, isA<Right<Failure, CartEntity>>());
      expect((result as Right).value, isA<CartEntity>());
    });

    test('should return error when removing product fails', () async {
      // Arrange
      when(() => mockApiConsumer.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                statusCode: 400,
                requestOptions: RequestOptions(),
              ));

      // Act
      final result = await cartRemoteDataSource.removeProduct(testCartItem);

      // Assert
      expect(result, isA<Left<Failure, CartEntity>>());
      expect((result as Left).value, isA<ServerFailure>());
    });

    test('should update product quantity successfully', () async {
      // Arrange
      when(() => mockApiConsumer.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                data: testCart.toJson(),
                statusCode: 200,
                requestOptions: RequestOptions(),
              ));

      // Act
      final result =
          await cartRemoteDataSource.updateProductQuantity(testCartItem);

      // Assert
      expect(result, isA<Right<Failure, CartEntity>>());
      expect((result as Right).value, isA<CartEntity>());
    });

    test('should return error when updating product quantity fails', () async {
      // Arrange
      when(() => mockApiConsumer.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                statusCode: 400,
                requestOptions: RequestOptions(),
              ));

      // Act
      final result =
          await cartRemoteDataSource.updateProductQuantity(testCartItem);

      // Assert
      expect(result, isA<Left<Failure, CartEntity>>());
      expect((result as Left).value, isA<ServerFailure>());
    });
  });
}
