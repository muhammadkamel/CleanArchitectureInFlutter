import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/domain/domain.dart';
import 'package:oth_app/src/infrastructure/infrastructure.dart';

// Mock classes
class MockProductRemoteDataSource extends Mock
    implements ProductRemoteDataSource {}

class MockProductLocalDataSource extends Mock
    implements ProductLocalDataSource {}

class MockInternetChecker extends Mock implements InternetChecker {}

void main() {
  late ProductRepositoryImpl productRepository;
  late MockProductRemoteDataSource mockProductRemoteDataSource;
  late MockProductLocalDataSource mockProductLocalDataSource;
  late MockInternetChecker mockInternetChecker;

  setUp(() {
    mockProductRemoteDataSource = MockProductRemoteDataSource();
    mockProductLocalDataSource = MockProductLocalDataSource();
    mockInternetChecker = MockInternetChecker();
    productRepository = ProductRepositoryImpl(
      productRemoteDataSource: mockProductRemoteDataSource,
      productLocalDataSource: mockProductLocalDataSource,
      internetChecker: mockInternetChecker,
    );
  });

  final List<ProductEntity> mockProducts = [
    ProductEntity(
      id: 3,
      title: 'title',
      price: 43,
      description: 'description',
      category: 'category',
      image: 'image',
      rating: RatingEntity(
        rate: 5,
        count: 3,
      ),
    ),
    ProductEntity(
      id: 3,
      title: 'title',
      price: 43,
      description: 'description',
      category: 'category',
      image: 'image',
      rating: RatingEntity(
        rate: 5,
        count: 3,
      ),
    ),
  ];

  final mockProductEntity = ProductEntity(
    id: 3,
    title: 'title',
    price: 43,
    description: 'description',
    category: 'category',
    image: 'image',
    rating: RatingEntity(
      rate: 5,
      count: 3,
    ),
  );
  final mockProductModel = ProductModel(
    id: 3,
    title: 'title',
    price: 43,
    description: 'description',
    category: 'category',
    image: 'image',
    rating: RatingModel(
      rate: 5,
      count: 3,
    ),
  );

  group('ProductRepositoryImpl Tests', () {
    test('should fetch products from remote when internet is connected',
        () async {
      // Arrange
      when(() => mockInternetChecker.isConnected).thenAnswer((_) async => true);
      when(() => mockProductRemoteDataSource.getProducts()).thenAnswer(
        (_) async => Right(mockProducts),
      );

      // Act
      final result = await productRepository.getProducts();

      // Assert
      verify(() => mockInternetChecker.isConnected).called(1);
      verify(() => mockProductRemoteDataSource.getProducts()).called(1);
      expect(result, Right(mockProducts));
    });

    test('should fetch products from local when internet is not connected',
        () async {
      // Arrange
      when(() => mockInternetChecker.isConnected)
          .thenAnswer((_) async => false);
      when(() => mockProductLocalDataSource.getProducts()).thenAnswer(
        (_) async => Right(mockProducts),
      );

      // Act
      final result = await productRepository.getProducts();

      // Assert
      verify(() => mockInternetChecker.isConnected).called(1);
      verify(() => mockProductLocalDataSource.getProducts()).called(1);
      expect(result, Right(mockProducts));
    });

    test('should fetch product by id from remote', () async {
      // Arrange
      when(() => mockProductRemoteDataSource.getProductById(any()))
          .thenAnswer((_) async => Right(mockProductEntity));

      // Act
      final result = await productRepository.getProductById(1);

      // Assert
      verify(() => mockProductRemoteDataSource.getProductById(1)).called(1);
      expect(result, Right(mockProductEntity));
    });

    test('should save products locally', () async {
      // Arrange
      when(() => mockProductLocalDataSource.saveProducts(any()))
          .thenAnswer((_) async => const Right(true));

      // Act
      final result = await productRepository.saveProducts([mockProductModel]);

      // Assert
      verify(() => mockProductLocalDataSource.saveProducts([mockProductModel]))
          .called(1);
      expect(result, const Right(null));
    });

    test('should return failure when remote call fails', () async {
      // Arrange
      final failure = ServerFailure('Server Failure');
      when(() => mockInternetChecker.isConnected).thenAnswer((_) async => true);
      when(() => mockProductRemoteDataSource.getProducts())
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await productRepository.getProducts();

      // Assert
      verify(() => mockInternetChecker.isConnected).called(1);
      verify(() => mockProductRemoteDataSource.getProducts()).called(1);
      expect(result, Left(failure));
    });
  });
}
