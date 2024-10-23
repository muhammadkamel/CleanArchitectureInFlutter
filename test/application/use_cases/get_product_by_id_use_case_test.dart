import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oth_app/src/application/use_cases/use_cases.dart';
import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/domain/domain.dart';

// Mock class for ProductRepository
class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late GetProductByIdUseCaseImpl getProductByIdUseCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    getProductByIdUseCase =
        GetProductByIdUseCaseImpl(productRepository: mockProductRepository);
  });

  final ProductEntity mockProduct = ProductEntity(
    id: 1,
    title: "Product Title",
    description: "Product Description",
    category: "Product Category",
    image: "Product Image",
    rating: RatingEntity(count: 10, rate: 4.5),
    price: 100.0,
  );

  test(
      'should call getProductById on ProductRepository and return ProductEntity',
      () async {
    // Arrange: Set up the repository to return a ProductEntity
    when(() => mockProductRepository.getProductById(any()))
        .thenAnswer((_) async => Right(mockProduct));

    // Act: Call the use case with the product id
    final result = await getProductByIdUseCase(3);

    // Assert: Check if the repository method was called and if the result is as expected
    verify(() => mockProductRepository.getProductById(3)).called(1);
    expect(result, Right(mockProduct));
  });

  test('should return failure when repository fails', () async {
    // Arrange: Set up the repository to return a failure
    final failure = ServerFailure(
      'Failed to get product',
    );
    when(() => mockProductRepository.getProductById(any()))
        .thenAnswer((_) async => Left(failure));

    // Act: Call the use case with the product id
    final result = await getProductByIdUseCase(3);

    // Assert: Check if the repository method was called and if the result is as expected
    verify(() => mockProductRepository.getProductById(3)).called(1);
    expect(result, Left(failure));
  });
}
