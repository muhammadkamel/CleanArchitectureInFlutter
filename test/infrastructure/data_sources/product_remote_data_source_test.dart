import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/domain/entities/product_entity.dart';
import 'package:oth_app/src/infrastructure/infrastructure.dart';

class MockApiConsumer extends Mock implements BaseApiConsumer {}

void main() {
  late ProductRemoteDataSourceImpl productRemoteDataSource;
  late MockApiConsumer mockApiConsumer;

  setUp(() {
    mockApiConsumer = MockApiConsumer();
    productRemoteDataSource =
        ProductRemoteDataSourceImpl(apiConsumer: mockApiConsumer);
  });

  group('ProductRemoteDataSourceImpl', () {
    final testProduct = ProductModel(
      id: 1,
      title: 'Test Product',
      description: "Test Description",
      category: 'Test Category',
      price: 99.99,
      image: 'test image',
      rating: RatingModel(rate: 4.5, count: 10),
    );

    test('should get products successfully', () async {
      // Arrange
      when(() => mockApiConsumer.get(Endpoints.products)).thenAnswer(
        (_) async => Response(
          data: [testProduct.toJson()],
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      // Act
      final result = await productRemoteDataSource.getProducts();

      // Assert
      expect(result, isA<Right<Failure, List<ProductEntity>>>());
      expect((result as Right).value, isA<List<ProductEntity>>());
    });

    test('should return error when getting products fails', () async {
      // Arrange
      when(() => mockApiConsumer.get(Endpoints.products)).thenAnswer(
        (_) async => Response(
          statusCode: 400,
          requestOptions: RequestOptions(),
        ),
      );

      // Act
      final result = await productRemoteDataSource.getProducts();

      // Assert
      expect(result, isA<Left<Failure, List<ProductEntity>>>());
      expect((result as Left).value, isA<ServerFailure>());
    });

    test('should get product by ID successfully', () async {
      // Arrange
      when(() => mockApiConsumer.get(any())).thenAnswer(
        (_) async => Response(
          data: testProduct.toJson(),
          statusCode: 200,
          requestOptions: RequestOptions(),
        ),
      );

      // Act
      final result = await productRemoteDataSource.getProductById(1);

      // Assert
      expect(result, isA<Right<Failure, ProductEntity>>());
      expect((result as Right).value, isA<ProductEntity>());
    });

    test('should return error when getting product by ID fails', () async {
      // Arrange
      when(() => mockApiConsumer.get(any())).thenAnswer(
        (_) async => Response(
          statusCode: 404,
          requestOptions: RequestOptions(),
        ),
      );

      // Act
      final result = await productRemoteDataSource.getProductById(1);

      // Assert
      expect(result, isA<Left<Failure, ProductEntity>>());
      expect((result as Left).value, isA<ServerFailure>());
    });
  });
}
