import 'package:flutter_test/flutter_test.dart';
import 'package:oth_app/src/domain/entities/cart_entity.dart';
import 'package:oth_app/src/presentation/presentation.dart';

void main() {
  group('CartState', () {
    final CartEntity testCart = CartEntity(
      id: 1,
      userId: 123,
      date: '2022-01-01',
      products: [],
      total: 10.0,
    );
    const CartState initialState = CartState(status: CartStatus.initial);

    test('initial state should have status as initial', () {
      // Arrange
      final cartState = CartState(status: CartStatus.initial);

      // Assert
      expect(cartState.status, CartStatus.initial);
      expect(cartState.cart, isNull);
    });

    test('copyWith should return a new instance with updated values', () {
      // Arrange
      final cartState = CartState(status: CartStatus.success, cart: testCart);

      // Act
      final newState = cartState.copyWith(status: CartStatus.loading);

      // Assert
      expect(newState.status, CartStatus.loading);
      expect(newState.cart, testCart);
    });

    test('copyWith should maintain the previous values when not provided', () {
      // Arrange
      final cartState = CartState(status: CartStatus.success, cart: testCart);

      // Act
      final newState = cartState.copyWith();

      // Assert
      expect(newState.status, CartStatus.success);
      expect(newState.cart, testCart);
    });

    test('maybeMap should return correct functions based on status', () {
      // Arrange
      final successState =
          CartState(status: CartStatus.success, cart: testCart);

      // Act & Assert
      successState.maybeMap(
        success: (state) {
          expect(state.status, CartStatus.success);
          expect(state.cart, testCart);
        },
        orElse: (state) {
          fail('Should have mapped to success');
        },
      );

      initialState.maybeMap(
        initial: (state) {
          expect(state.status, CartStatus.initial);
          expect(state.cart, isNull);
        },
        orElse: (state) {
          fail('Should have mapped to initial');
        },
      );
    });
  });
}
