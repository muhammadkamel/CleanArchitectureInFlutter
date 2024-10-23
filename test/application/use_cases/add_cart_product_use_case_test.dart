import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oth_app/src/application/application.dart';
import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/domain/domain.dart';

// Mock class for CartRepository
class MockCartRepository extends Mock implements CartRepository {}

void main() {
  late AddCartProductUseCaseImpl addCartProductUseCase;
  late MockCartRepository mockCartRepository;

  setUp(() {
    mockCartRepository = MockCartRepository();
    addCartProductUseCase =
        AddCartProductUseCaseImpl(cartRepository: mockCartRepository);
    registerFallbackValue(CartItemEntity(productId: 2, quantity: 1));
  });

  final CartItemEntity mockCartItem = CartItemEntity(
    productId: 1,
    name: 'Product 1',
    quantity: 1,
  );

  final CartEntity mockCart = CartEntity(
    id: 1,
    userId: 1,
    date: '2022-01-01',
    products: [mockCartItem],
    total: 10.0,
  );

  test('should call addProduct on CartRepository and return CartEntity',
      () async {
    // Arrange: Set up the repository to return a CartEntity
    when(() => mockCartRepository.addProduct(any()))
        .thenAnswer((_) async => Right(mockCart));

    // Act: Call the use case with a product
    final result = await addCartProductUseCase(mockCartItem);

    // Assert: Check if the repository method was called and if the result is as expected
    verify(() => mockCartRepository.addProduct(mockCartItem)).called(1);
    expect(result, Right(mockCart));
  });

  test('should return failure when repository fails', () async {
    // Arrange: Set up the repository to return a failure
    final failure = ServerFailure("Something went wrong");
    when(() => mockCartRepository.addProduct(any()))
        .thenAnswer((_) async => Left(failure));

    // Act: Call the use case with a product
    final result = await addCartProductUseCase(mockCartItem);

    // Assert
    verify(() => mockCartRepository.addProduct(mockCartItem)).called(1);
    expect(result, Left(failure));
  });
}
