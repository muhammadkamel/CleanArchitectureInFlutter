import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oth_app/src/application/application.dart'; // Adjust based on your project structure
import 'package:oth_app/src/core/core.dart';
import 'package:oth_app/src/domain/domain.dart';
import 'package:oth_app/src/presentation/presentation.dart';

class MockGetProductsUseCase extends Mock implements GetProductsUseCase {}

class MockGetProductByIdUseCase extends Mock implements GetProductByIdUseCase {}

class MockSaveProductsLocalUseCase extends Mock
    implements SaveProductsLocalUseCase {}

final product = ProductEntity(
  title: "Test Product",
  id: 1,
  price: 20.0,
  description: 'desc',
  category: 'category',
  image: 'image',
  rating: RatingEntity(count: 10, rate: 4.5),
);

void main() {
  late ProductBloc productBloc;
  late MockGetProductsUseCase mockGetProductsUseCase;
  late MockGetProductByIdUseCase mockGetProductByIdUseCase;
  late MockSaveProductsLocalUseCase mockSaveProductsLocalUseCase;

  setUp(() {
    mockGetProductsUseCase = MockGetProductsUseCase();
    mockGetProductByIdUseCase = MockGetProductByIdUseCase();
    mockSaveProductsLocalUseCase = MockSaveProductsLocalUseCase();

    productBloc = ProductBloc(
      productUseCase: mockGetProductsUseCase,
      productByIdUseCase: mockGetProductByIdUseCase,
      saveProductsLocalUseCase: mockSaveProductsLocalUseCase,
    );
  });

  tearDown(() {
    productBloc.close();
  });

  group('ProductBloc', () {
    test('initial state is ProductStatus.initial', () {
      expect(productBloc.state.status, ProductStatus.initial);
    });

    blocTest<ProductBloc, ProductState>(
      'emits [loading, success] when GetProductsEvent is added',
      build: () {
        when(() => mockGetProductsUseCase.call(any()))
            .thenAnswer((_) async => right(<ProductEntity>[]));
        when(() => mockSaveProductsLocalUseCase.call(any()))
            .thenAnswer((_) async => Right(true));
        return productBloc;
      },
      act: (bloc) => bloc.add(GetProductsEvent()),
      expect: () => [
        ProductState(status: ProductStatus.loading),
        ProductState(
          status: ProductStatus.success,
          products: [],
        ),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [loading, failure] when GetProductsEvent fails',
      build: () {
        when(() => mockGetProductsUseCase.call(any()))
            .thenThrow(Exception('Error'));
        return productBloc;
      },
      act: (bloc) => bloc.add(GetProductsEvent()),
      expect: () => [
        ProductState(status: ProductStatus.loading),
        ProductState(
            status: ProductStatus.failure, message: 'Exception: Error'),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [loading, success] when RefreshProductsEvent is added',
      build: () {
        when(() => mockGetProductsUseCase.call(any())).thenAnswer(
          (_) async => Right(
            [
              product,
            ],
          ),
        );
        return productBloc;
      },
      act: (bloc) => bloc.add(RefreshProductsEvent()),
      expect: () => [
        ProductState(status: ProductStatus.loading),
        ProductState(status: ProductStatus.success, products: [
          product,
        ]),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [loading, success] when GetProductByIdEvent is added',
      build: () {
        final product = ProductEntity(
          title: "Test Product",
          id: 1,
          price: 20.0,
          description: 'desc',
          category: 'category',
          image: 'image',
          rating: RatingEntity(count: 10, rate: 4.5),
        );
        when(() => mockGetProductByIdUseCase.call(1))
            .thenAnswer((_) async => right(product));
        return productBloc;
      },
      act: (bloc) => bloc.add(GetProductByIdEvent(productId: 1)),
      expect: () => [
        ProductState(status: ProductStatus.loading),
        ProductState(
          status: ProductStatus.success,
          product: ProductEntity(
            title: "Test Product",
            id: 1,
            price: 20.0,
            description: 'desc',
            category: 'category',
            image: 'image',
            rating: RatingEntity(count: 10, rate: 4.5),
          ),
        ),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [loading, failure] when GetProductByIdEvent fails',
      build: () {
        when(() => mockGetProductByIdUseCase.call(1)).thenAnswer(
            (_) async => left(ServerFailure('Error fetching product')));
        return productBloc;
      },
      act: (bloc) => bloc.add(GetProductByIdEvent(productId: 1)),
      expect: () => [
        ProductState(status: ProductStatus.loading),
        ProductState(
            status: ProductStatus.failure, message: 'Error fetching product'),
      ],
    );
  });
}
