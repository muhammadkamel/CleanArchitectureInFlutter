import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oth_app/src/application/application.dart';
import 'package:oth_app/src/application/use_cases/use_cases.dart';
import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/domain/domain.dart';
import 'package:oth_app/src/domain/repositories/repositories.dart';
import 'package:oth_app/src/infrastructure/infrastructure.dart';

// Mock class for ProductRepository
class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late SaveProductsLocalUseCaseImpl saveProductsLocalUseCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    saveProductsLocalUseCase =
        SaveProductsLocalUseCaseImpl(productRepository: mockProductRepository);
  });

  final List<ProductModel> mockProductModels = [
    ProductModel(
      id: 2,
      title: 'Product title',
      price: 33,
      description: 'Product description',
      category: 'Product category',
      image: "image",
      rating: RatingModel(rate: 4.9, count: 3),
    ),
  ];

  test('should call saveProducts on ProductRepository and return success',
      () async {
    // Arrange: Set up the repository to succeed
    when(() => mockProductRepository.saveProducts(any()))
        .thenAnswer((_) async => const Right(true));

    // Act: Call the use case
    final result = await saveProductsLocalUseCase(mockProductModels);

    // Assert: Check if the repository method was called and if the result is as expected
    verify(() => mockProductRepository.saveProducts(mockProductModels))
        .called(1);
    expect(result, const Right(null));
  });

  test('should return failure when repository fails', () async {
    // Arrange: Set up the repository to return a failure
    final failure = ServerFailure('Failed to save products');
    when(() => mockProductRepository.saveProducts(any()))
        .thenAnswer((_) async => Left(failure));

    // Act: Call the use case
    final result = await saveProductsLocalUseCase(mockProductModels);

    // Assert: Check if the repository method was called and if the result is as expected
    verify(() => mockProductRepository.saveProducts(mockProductModels))
        .called(1);
    expect(result, Left(failure));
  });
}
