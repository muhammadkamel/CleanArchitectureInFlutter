import 'package:equatable/equatable.dart';

import 'cart_item_entity.dart';

class CartEntity extends Equatable {
  final int id;
  final int userId;
  final String date;
  final List<CartItemEntity> products;
  final double total;

  const CartEntity({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
    required this.total,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        date,
        products,
        total,
      ];

  CartEntity copyWith({
    int? id,
    int? userId,
    String? date,
    List<CartItemEntity>? products,
    double? total,
  }) {
    return CartEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      products: products ?? this.products,
      total: total ?? this.total,
    );
  }

  /// Calculate the total price of the cart
  double calculateTotal(double? price) {
    double total = 0.0;
    for (final product in products) {
      total += product.price + (price ?? 0.0);
      // total += product.price * product.quantity;
    }

    String formattedNumber = total.toStringAsFixed(2);
    total = double.parse(formattedNumber);

    return total;
  }
}
