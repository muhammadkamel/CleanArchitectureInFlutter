import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oth_app/src/application/use_cases/use_cases.dart';
import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/domain/domain.dart';

// Mock class for ProductRepository
class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late GetProductsUseCaseImpl getProductsUseCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    getProductsUseCase =
        GetProductsUseCaseImpl(productRepository: mockProductRepository);
  });

  final List<ProductEntity> mockProducts = [
    ProductEntity(
      id: 2,
      title: "Product 1",
      rating: RatingEntity(count: 10, rate: 4.5),
      price: 100.0,
      description: 'Product 1 description',
      category: 'Category 1',
      image: 'image1.jpg',
    ),
    ProductEntity(
      id: 2,
      title: "Product 1",
      rating: RatingEntity(count: 10, rate: 4.5),
      price: 100.0,
      description: 'Product 1 description',
      category: 'Category 1',
      image: 'image1.jpg',
    ),
  ];

  test(
      'should call getProducts on ProductRepository and return a list of ProductEntity',
      () async {
    // Arrange: Set up the repository to return a list of ProductEntity
    when(() => mockProductRepository.getProducts())
        .thenAnswer((_) async => Right(mockProducts));

    // Act: Call the use case
    final result = await getProductsUseCase(null);

    // Assert: Check if the repository method was called and if the result is as expected
    verify(() => mockProductRepository.getProducts()).called(1);
    expect(result, Right(mockProducts));
  });

  test('should return failure when repository fails', () async {
    // Arrange: Set up the repository to return a failure
    final failure = ServerFailure("Failed to get products");
    when(() => mockProductRepository.getProducts())
        .thenAnswer((_) async => Left(failure));

    // Act: Call the use case
    final result = await getProductsUseCase(null);

    // Assert: Check if the repository method was called and if the result is as expected
    verify(() => mockProductRepository.getProducts()).called(1);
    expect(result, Left(failure));
  });
}
