import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oth_app/src/application/use_cases/use_cases.dart';
import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/domain/domain.dart';

// Mock class for CartRepository
class MockCartRepository extends Mock implements CartRepository {}

void main() {
  late GetCartByIdUseCaseImpl getCartByIdUseCase;
  late MockCartRepository mockCartRepository;

  setUp(() {
    mockCartRepository = MockCartRepository();
    getCartByIdUseCase =
        GetCartByIdUseCaseImpl(cartRepository: mockCartRepository);
  });

  const String cartId = 'cart1';

  final CartEntity mockCart = CartEntity(
    id: 1,
    userId: 1,
    date: '2022-01-01',
    products: [],
    total: 10.0,
  );

  test('should call getCartById on CartRepository and return CartEntity',
      () async {
    // Arrange: Set up the repository to return a CartEntity
    when(() => mockCartRepository.getCartById(any()))
        .thenAnswer((_) async => Right(mockCart));

    // Act: Call the use case with the cart id
    final result = await getCartByIdUseCase(cartId);

    // Assert: Check if the repository method was called
    verify(() => mockCartRepository.getCartById(cartId)).called(1);
    expect(result, Right(mockCart));
  });

  test('should return failure when repository fails', () async {
    // Arrange: Set up the repository to return a failure
    final failure = ServerFailure(
      'Failed to get cart',
    );
    when(() => mockCartRepository.getCartById(any()))
        .thenAnswer((_) async => Left(failure));

    // Act: Call the use case with the cart id
    final result = await getCartByIdUseCase(cartId);

    // Assert: Check if the repository method was called
    verify(() => mockCartRepository.getCartById(cartId)).called(1);
    expect(result, Left(failure));
  });
}
