import 'package:flutter_test/flutter_test.dart';
import 'package:oth_app/src/presentation/presentation.dart';

void main() {
  group('ProductEvent', () {
    test('GetProductsEvent equality check', () {
      final event1 = GetProductsEvent();
      final event2 = GetProductsEvent();

      expect(event1, event2);
    });

    test('RefreshProductsEvent equality check', () {
      final event1 = RefreshProductsEvent();
      final event2 = RefreshProductsEvent();

      expect(event1, event2);
    });

    test('GetProductByIdEvent equality check', () {
      final event1 = GetProductByIdEvent(productId: 1);
      final event2 = GetProductByIdEvent(productId: 1);
      final event3 = GetProductByIdEvent(productId: 2);

      expect(event1, event2);
      expect(event1, isNot(event3));
    });

    test('GetProductByIdEvent props returns correct values', () {
      final event = GetProductByIdEvent(productId: 1);

      expect(event.props, [1]);
    });
  });
}
