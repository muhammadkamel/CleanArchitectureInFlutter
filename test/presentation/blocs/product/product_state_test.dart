import 'package:flutter_test/flutter_test.dart';
import 'package:oth_app/src/domain/domain.dart';
import 'package:oth_app/src/presentation/presentation.dart';

void main() {
  group('ProductState', () {
    final ProductEntity testProduct = ProductEntity(
      id: 4,
      title: 'Test Product',
      price: 20.0,
      description: 'desc',
      category: 'category',
      image: 'image',
      rating: RatingEntity(count: 10, rate: 4.5),
    );

    test('initial state is correctly set', () {
      final state = ProductState(
        status: ProductStatus.initial,
      );

      expect(state.status, ProductStatus.initial);
      expect(state.product, isNull);
      expect(state.products, isNull);
      expect(state.message, isNull);
    });

    test('copyWith returns new state with updated values', () {
      final state = ProductState(
        status: ProductStatus.success,
        product: testProduct,
        products: [testProduct],
        message: 'Product loaded successfully',
      );

      final newState = state.copyWith(
        status: ProductStatus.loading,
        message: 'Loading products...',
      );

      expect(newState.status, ProductStatus.loading);
      expect(newState.product, testProduct);
      expect(newState.products, [testProduct]);
      expect(newState.message, 'Loading products...');
    });

    test('props includes status, product, products, and message', () {
      final state = ProductState(
        status: ProductStatus.success,
        product: testProduct,
        products: [testProduct],
        message: 'Product loaded successfully',
      );

      expect(state.props, [
        ProductStatus.success,
        testProduct,
        [testProduct],
        'Product loaded successfully',
      ]);
    });

    test('maybeMap works correctly for initial state', () {
      final state = ProductState(status: ProductStatus.initial);

      final result = state.maybeMap(
        initial: (_) => 'Initial State',
        orElse: (_) => 'Not Initial',
      );

      expect(result, 'Initial State');
    });

    test('maybeMap works correctly for loading state', () {
      final state = ProductState(status: ProductStatus.loading);

      final result = state.maybeMap(
        loading: (_) => 'Loading State',
        orElse: (_) => 'Not Loading',
      );

      expect(result, 'Loading State');
    });

    test('maybeMap works correctly for success state', () {
      final state = ProductState(status: ProductStatus.success);

      final result = state.maybeMap(
        success: (_) => 'Success State',
        orElse: (_) => 'Not Success',
      );

      expect(result, 'Success State');
    });

    test('maybeMap works correctly for failure state', () {
      final state = ProductState(status: ProductStatus.failure);

      final result = state.maybeMap(
        failure: (_) => 'Failure State',
        orElse: (_) => 'Not Failure',
      );

      expect(result, 'Failure State');
    });
  });
}
