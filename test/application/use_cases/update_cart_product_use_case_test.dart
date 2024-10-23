import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oth_app/src/application/application.dart';
import 'package:oth_app/src/application/use_cases/use_cases.dart';
import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/domain/domain.dart';

// Mock class for CartRepository
class MockCartRepository extends Mock implements CartRepository {}

void main() {
  late UpdateCartProductUseCaseImpl updateCartProductUseCase;
  late MockCartRepository mockCartRepository;

  setUp(() {
    mockCartRepository = MockCartRepository();
    updateCartProductUseCase =
        UpdateCartProductUseCaseImpl(cartRepository: mockCartRepository);
    registerFallbackValue(CartItemEntity(productId: 2, quantity: 1));
  });

  final mockCartItem = CartItemEntity(productId: 2, quantity: 1);

  final mockCart = CartEntity(
    id: 1,
    userId: 1,
    date: '2022-01-01',
    products: [
      CartItemEntity(productId: 2, quantity: 1),
      CartItemEntity(productId: 3, quantity: 1),
    ],
    total: 10.0,
  );

  test(
      'should call updateProductQuantity on CartRepository and return updated CartEntity',
      () async {
    // Arrange: Set up the repository to return an updated CartEntity
    when(() => mockCartRepository.updateProductQuantity(any()))
        .thenAnswer((_) async => Right(mockCart));

    // Act: Call the use case with the CartItemEntity
    final result = await updateCartProductUseCase(mockCartItem);

    // Assert: Check if the repository method was called and if the result is as expected
    verify(() => mockCartRepository.updateProductQuantity(mockCartItem))
        .called(1);
    expect(result, Right(mockCart));
  });

  test('should return failure when repository fails', () async {
    // Arrange: Set up the repository to return a failure
    final failure = ServerFailure("Failed to update product quantity");
    when(() => mockCartRepository.updateProductQuantity(any()))
        .thenAnswer((_) async => Left(failure));

    // Act: Call the use case with the CartItemEntity
    final result = await updateCartProductUseCase(mockCartItem);

    // Assert: Check if the repository method was called and if the result is as expected
    verify(() => mockCartRepository.updateProductQuantity(mockCartItem))
        .called(1);
    expect(result, Left(failure));
  });
}
