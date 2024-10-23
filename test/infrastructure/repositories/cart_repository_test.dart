import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/domain/domain.dart';
import 'package:oth_app/src/infrastructure/infrastructure.dart';

// Mock class for CartRemoteDataSource
class MockCartRemoteDataSource extends Mock implements CartRemoteDataSource {}

void main() {
  late CartRepositoryImpl cartRepository;
  late MockCartRemoteDataSource mockCartRemoteDataSource;

  setUp(() {
    mockCartRemoteDataSource = MockCartRemoteDataSource();
    cartRepository =
        CartRepositoryImpl(cartDataSource: mockCartRemoteDataSource);
    registerFallbackValue(CartItemEntity(productId: 2, quantity: 1));
  });

  final CartItemEntity mockCartItem = CartItemEntity(
    productId: 1,
    name: 'Product 1',
    quantity: 1,
  );

  final mockCart = CartEntity(
    id: 1,
    userId: 1,
    date: '2022-01-01',
    products: [mockCartItem],
    total: 10.0,
  );

  group('CartRepositoryImpl Tests', () {
    test('should call addProduct on CartRemoteDataSource and return CartEntity',
        () async {
      // Arrange
      when(() => mockCartRemoteDataSource.addProduct(any()))
          .thenAnswer((_) async => Right(mockCart));

      // Act
      final result = await cartRepository.addProduct(mockCartItem);

      // Assert
      verify(() => mockCartRemoteDataSource.addProduct(mockCartItem)).called(1);
      expect(result, Right(mockCart));
    });

    test(
        'should call getCartById on CartRemoteDataSource and return CartEntity',
        () async {
      // Arrange
      when(() => mockCartRemoteDataSource.getCartById(any()))
          .thenAnswer((_) async => Right(mockCart));

      // Act
      final result = await cartRepository.getCartById('cart1');

      // Assert
      verify(() => mockCartRemoteDataSource.getCartById('cart1')).called(1);
      expect(result, Right(mockCart));
    });

    test(
        'should call removeProduct on CartRemoteDataSource and return CartEntity',
        () async {
      // Arrange
      when(() => mockCartRemoteDataSource.removeProduct(any()))
          .thenAnswer((_) async => Right(mockCart));

      // Act
      final result = await cartRepository.removeProduct(mockCartItem);

      // Assert
      verify(() => mockCartRemoteDataSource.removeProduct(mockCartItem))
          .called(1);
      expect(result, Right(mockCart));
    });

    test(
        'should call updateProductQuantity on CartRemoteDataSource and return CartEntity',
        () async {
      // Arrange
      when(() => mockCartRemoteDataSource.updateProductQuantity(any()))
          .thenAnswer((_) async => Right(mockCart));

      // Act
      final result = await cartRepository.updateProductQuantity(mockCartItem);

      // Assert
      verify(() => mockCartRemoteDataSource.updateProductQuantity(mockCartItem))
          .called(1);
      expect(result, Right(mockCart));
    });

    test('should return failure when CartRemoteDataSource fails', () async {
      // Arrange
      final failure = ServerFailure("Something went wrong");
      when(() => mockCartRemoteDataSource.addProduct(any()))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await cartRepository.addProduct(mockCartItem);

      // Assert
      verify(() => mockCartRemoteDataSource.addProduct(mockCartItem)).called(1);
      expect(result, Left(failure));
    });
  });
}
