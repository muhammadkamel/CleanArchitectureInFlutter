import 'package:flutter_test/flutter_test.dart';
import 'package:oth_app/src/domain/domain.dart';
import 'package:oth_app/src/presentation/presentation.dart';

void main() {
  group('CartEvent', () {
    test('GetCartByIdEvent should have correct properties', () {
      // Arrange
      const event = GetCartByIdEvent('1');

      // Act & Assert
      expect(event.id, '1');
      expect(event.props, ['1']);
    });

    test('AddToCartEvent should have correct properties', () {
      // Arrange
      final testProduct = CartItemEntity(productId: 3, quantity: 1);
      const event = AddToCartEvent(CartItemEntity(productId: 3, quantity: 1));

      // Act & Assert
      expect(event.product, testProduct);
      expect(event.props, [testProduct]);
    });

    test('RemoveFromCartEvent should have correct properties', () {
      // Arrange
      final testProduct = CartItemEntity(productId: 3, quantity: 1);
      const event =
          RemoveFromCartEvent(CartItemEntity(productId: 3, quantity: 1));

      // Act & Assert
      expect(event.product, testProduct);
      expect(event.props, [testProduct]);
    });

    test('GetCartByIdEvent equality', () {
      // Arrange
      const event1 = GetCartByIdEvent('1');
      const event2 = GetCartByIdEvent('1');
      const event3 = GetCartByIdEvent('2');

      // Act & Assert
      expect(event1, event2); // should be equal
      expect(event1, isNot(event3)); // should not be equal
    });

    test('AddToCartEvent equality', () {
      // Arrange
      final product1 = CartItemEntity(productId: 1, quantity: 2);
      final product2 = CartItemEntity(productId: 1, quantity: 2);
      final product3 = CartItemEntity(productId: 2, quantity: 1);

      final event1 = AddToCartEvent(product1);
      final event2 = AddToCartEvent(product2);
      final event3 = AddToCartEvent(product3);

      // Act & Assert
      expect(event1, event2); // should be equal
      expect(event1, isNot(event3)); // should not be equal
    });

    test('RemoveFromCartEvent equality', () {
      // Arrange
      final product1 = CartItemEntity(productId: 2, quantity: 1);
      final product2 = CartItemEntity(productId: 2, quantity: 1);
      final product3 = CartItemEntity(productId: 1, quantity: 2);

      final event1 = RemoveFromCartEvent(product1);
      final event2 = RemoveFromCartEvent(product2);
      final event3 = RemoveFromCartEvent(product3);

      // Act & Assert
      expect(event1, event2); // should be equal
      expect(event1, isNot(event3)); // should not be equal
    });
  });
}
